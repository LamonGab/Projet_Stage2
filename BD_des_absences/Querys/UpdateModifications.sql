DECLARE @table NVARCHAR(MAX);
DECLARE @tempTable NVARCHAR(MAX);
DECLARE @modTable NVARCHAR(MAX);
DECLARE @columns NVARCHAR(MAX) = '';
DECLARE @columnsList NVARCHAR(MAX) = '';
DECLARE @keyColumn NVARCHAR(MAX);
DECLARE @dateColumn NVARCHAR(MAX);
DECLARE @onJoin NVARCHAR(MAX);
DECLARE @filePath NVARCHAR(MAX);
DECLARE @sql NVARCHAR(MAX);
DECLARE @columnsToInsert NVARCHAR(MAX) = '';
DECLARE @columnsToInsertCase NVARCHAR(MAX) = '';
DECLARE @updateCondition NVARCHAR(MAX) = '';

--Déclare un curseur
DECLARE table_cursor CURSOR FOR
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE 'BDIP_%' AND TABLE_TYPE = 'BASE TABLE' AND TABLE_NAME NOT LIKE 'BDIP_DateMAJ' AND TABLE_NAME NOT LIKE '%Modifications';

OPEN table_cursor;

FETCH NEXT FROM table_cursor INTO @table;

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @tempTable = 'temp' + @table;
	SET @modTable = @table + 'Modifications';

	--Récupère une liste de toutes les colonnes de @table en ajoutant @tempTable + '.' devant
	SELECT @columns = STRING_AGG(CAST(@tempTable + '.' + name + ' NVARCHAR(255)' AS NVARCHAR(MAX)), ', ')
	FROM sys.columns
	WHERE object_id = OBJECT_ID(@table);

	--Crée une table temporaire pour écarter les doublons présents dans les fichiers .csv
	--Vérifie si la table n'existe pas déjà et la supprime si c'est le cas
	IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DataCleaner')
	BEGIN
		SET @sql = '
			CREATE TABLE DataCleaner (
				' + REPLACE(@columns, @tempTable + '.', '') + '
			);';

		EXEC sp_executesql @sql;
	END
	ELSE
	BEGIN
		SET @sql = 'DROP TABLE IF EXISTS DataCleaner;';
		EXEC sp_executesql @sql;

		SET @sql = '
			CREATE TABLE DataCleaner (
				' + REPLACE(@columns, @tempTable + '.', '') + '
			);';

		EXEC sp_executesql @sql;
	END

	--Crée une table temporaire pour éviter d'avoir des doublons dans la base de données
	--Vérifie si la table n'existe pas déjà et la supprime si c'est le cas
	IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @tempTable)
	BEGIN
		SET @sql = '
			CREATE TABLE ' + @tempTable + ' (
				' + REPLACE(@columns, @tempTable + '.', '') + '
			);';

		EXEC sp_executesql @sql;
	END
	ELSE
	BEGIN
		SET @sql = 'DROP TABLE IF EXISTS ' + @tempTable + ';';
		EXEC sp_executesql @sql;

		SET @sql = '
			CREATE TABLE ' + @tempTable + ' (
				' + REPLACE(@columns, @tempTable + '.', '') + '
			);';

		EXEC sp_executesql @sql;
	END

	SET @columns = REPLACE(@columns, ' NVARCHAR(255)', '');

	--Récupère le chemin d'accès vers le fichier .csv recherché
	SELECT @filePath = FilePath
	FROM FileMapping
	WHERE TableName = @table;

	--Détermine le nom de la colonne clé qui sert de référence pour les doublons
	--Détermine la condition du LEFT JOIN (utile pour les cas où la colonne clé est NuméroÉvénementParent puisqu'il peut être présent plusieurs fois sans être un doublon)
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @table AND COLUMN_NAME = 'NuméroÉvénement')
    BEGIN
        SET @keyColumn = 'NuméroÉvénement';
		SET @onJoin = @table + '.' + 'NuméroÉvénement' + ' = ' + @tempTable + '.' + 'NuméroÉvénement';
    END
    ELSE IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @table AND COLUMN_NAME = 'NuméroÉvénementParent')
    BEGIN
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @table AND COLUMN_NAME = 'DateDébut')
		BEGIN
			SET @dateColumn = 'DateDébut';
		END
		ELSE IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @table AND COLUMN_NAME = 'DateDébutCSQ')
		BEGIN
			SET @dateColumn = 'DateDébutCSQ';
		END
		ELSE IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @table AND COLUMN_NAME = 'Date')
		BEGIN
			SET @dateColumn = 'Date';
		END
		ELSE
		BEGIN
			RAISERROR('Erreur : La table %s ne contient ni la colonne ''DateDébut'' ni la colonne ''DateDébutCSQ'' ni la colonne ''Date''.', 16, 1, @table);
		END
        SET @keyColumn = 'NuméroÉvénementParent';
		SET @onJoin = @table + '.' + @keyColumn + ' = ' + @tempTable + '.' + @keyColumn + ' AND ' + @table + '.' + @dateColumn + ' = ' + @tempTable + '.' + @dateColumn;
    END
	ELSE
    BEGIN
        RAISERROR('Erreur : La table %s ne contient ni la colonne ''NuméroÉvénement'' ni la colonne ''NuméroÉvénementParent''.', 16, 1, @table);
    END

	--Vérifie que la table temporaire existe
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @tempTable AND TABLE_TYPE = 'BASE TABLE')
	BEGIN
		--Insère les données dans la première table temporaire
		SET @sql = '
		BULK INSERT dbo.DataCleaner
		FROM ''' + @filePath + '''
		WITH (
			FIELDTERMINATOR = ''\'',
			ROWTERMINATOR = ''\n'',
			FIRSTROW = 2,
			CODEPAGE = ''65001''
		);';

		EXEC sp_executesql @sql;

		--Insère les données dans la table temporaire en ignorant les doublons avec un SELECT DISTINCT
		SET @sql = '
		INSERT INTO ' + @tempTable + '
		SELECT DISTINCT *
		FROM DataCleaner;';

		EXEC sp_executesql @sql;

		--Crée une série de condition "Égale à" qui va permettre de vérifier si une données a été modifiée dans une ligne de donnée
		SELECT @columnsList = STRING_AGG(CAST(@table + '.' + name + ' = ' + @tempTable + '.' + name AS NVARCHAR(MAX)), ' OR ')
		FROM sys.columns
		WHERE object_id = OBJECT_ID(@table);

		--Récupère la valeur d'une colonne lorsque la valeur reçue diffère de la valeur dans la base de données
		SELECT @columnsToInsertCase = STRING_AGG(
            'CASE WHEN [' + @table + '].[' + name + '] <> [' + @tempTable + '].[' + name + '] THEN [' + @tempTable + '].[' + name + '] ELSE NULL END AS [' + name + ']', 
            ', '
        ), @columnsToInsert = STRING_AGG(CAST(@tempTable + '.' + name AS NVARCHAR(MAX)), ', ')
        FROM sys.columns
        WHERE object_id = OBJECT_ID(@table) AND name <> @keyColumn AND name <> 'Matricule';

		--Crée une série de condition "Différent de" qui va permettre de vérifier si une données a été modifiée dans une ligne de donnée
        SELECT @updateCondition = STRING_AGG(
            '[' + @table + '].[' + name + '] <> [' + @tempTable + '].[' + name + ']', 
            ' OR '
        )
        FROM sys.columns
        WHERE object_id = OBJECT_ID(@table);

		--Insère les modifications dans la table de modifications correspondante lorsqu'il y a une modification d'une donnée (1)
		--Insère les informations principales dans la table Modifications lorsqu'il y a une modification (2)
        SET @sql = '
        INSERT INTO ' + @modTable + ' (' + @columnsToInsert + ', ' + @keyColumn + ', Matricule, StatutDonnée)
        SELECT ' + @columnsToInsertCase + ', ' + @tempTable + '.' + @keyColumn + ', ' + @tempTable + '.Matricule' + ', ''Modifié''
        FROM ' + @tempTable + '
        LEFT JOIN ' + @table + ' ON ' + @onJoin + '
        WHERE ' + @table + '.' + @keyColumn + ' IS NOT NULL
          AND (' + @updateCondition + ')
		  
		INSERT INTO Modifications (NomTable, NuméroÉvénement, StatutDonnée)
		SELECT ''' + @table + ''', ' + @tempTable + '.' + @keyColumn + ', ''Modifié''
		FROM ' + @tempTable + '
		LEFT JOIN ' + @table + ' ON ' + @onJoin + '
		WHERE ' + @table + '.' + @keyColumn + ' IS NOT NULL
          AND (' + @updateCondition + ');';

        EXEC sp_executesql @sql;

		--Insère les informations dans la table de modifications correspondante lorsqu'il y a une nouvelle donnée
		SET @sql = '
		INSERT INTO ' + @modTable + ' (' + REPLACE(@columns, @tempTable, @table) + ', StatutDonnée)
		SELECT ' + @columns + ', ''Nouveau''
		FROM ' + @tempTable + '
		LEFT JOIN ' + @table + ' ON ' + @onJoin + '
		WHERE NOT EXISTS (
			SELECT 1
			FROM ' + @table + '
			WHERE ' + @table + '.' + @keyColumn + ' IS NOT NULL
		);';

		EXEC sp_executesql @sql;

		--Insère les informations principales dans la table Modifications lorsqu'il y a une nouvelle donnée
		SET @sql = '
		INSERT INTO Modifications (NomTable, NuméroÉvénement, StatutDonnée)
		SELECT ''' + @table + ''', ' + @tempTable + '.' + @keyColumn + ', ''Nouveau''
		FROM ' + @tempTable + '
		LEFT JOIN ' + @table + ' ON ' + @onJoin + '
		WHERE NOT EXISTS (
			SELECT 1
			FROM ' + @table + '
			WHERE ' + @table + '.' + @keyColumn + ' IS NOT NULL' + ' AND (' + @columnsList + ')
		);';

		EXEC sp_executesql @sql;

		--Supprime les lignes de la base de données qui ont une modification disponible dans la table temporaire
		SET @sql = '
		DELETE FROM ' + @table + '
		WHERE EXISTS (
			SELECT 1
			FROM ' + @tempTable + '
			WHERE ' + @onJoin + ' AND (' + @columnsList + ')
		);';

		EXEC sp_executesql @sql;

		--Insère les nouvelles données ainsi que les données modifiées dans la base de données
		SET @sql = '
		INSERT INTO ' + @table + ' (' + REPLACE(@columns, @tempTable, @table) + ')
		SELECT ' + @columns + '
		FROM ' + @tempTable + '
		LEFT JOIN ' + @table + ' ON ' + @onJoin + '
		WHERE ' + @table + '.' + @keyColumn + ' IS NULL;';

		EXEC sp_executesql @sql;

		--Supprime la table temporaire
		--SET @sql = 'TRUNCATE TABLE ' + @tempTable;
		SET @sql = 'DROP TABLE IF EXISTS ' + @tempTable + ';';
		EXEC sp_executesql @sql;

		--Supprime la table temporaire intermédiaire
		SET @sql = 'DROP TABLE IF EXISTS DataCleaner;';
		EXEC sp_executesql @sql;
	END

	FETCH NEXT FROM table_cursor INTO @table;
END

--Désalloue le curseur
CLOSE table_cursor;
DEALLOCATE table_cursor;

-- Conserve la date  heure de la dernière mise à jour
TRUNCATE TABLE BDIP_DateMAJ
INSERT INTO BDIP_DateMAJ
SELECT DateMAJ = CONVERT(DATETIME2(0), SYSDATETIME())
