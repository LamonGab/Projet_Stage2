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

--D�clare un curseur
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

	--R�cup�re une liste de toutes les colonnes de @table en ajoutant @tempTable + '.' devant
	SELECT @columns = STRING_AGG(CAST(@tempTable + '.' + name + ' NVARCHAR(255)' AS NVARCHAR(MAX)), ', ')
	FROM sys.columns
	WHERE object_id = OBJECT_ID(@table);

	--Cr�e une table temporaire pour �carter les doublons pr�sents dans les fichiers .csv
	--V�rifie si la table n'existe pas d�j� et la supprime si c'est le cas
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

	--Cr�e une table temporaire pour �viter d'avoir des doublons dans la base de donn�es
	--V�rifie si la table n'existe pas d�j� et la supprime si c'est le cas
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

	--R�cup�re le chemin d'acc�s vers le fichier .csv recherch�
	SELECT @filePath = FilePath
	FROM FileMapping
	WHERE TableName = @table;

	--D�termine le nom de la colonne cl� qui sert de r�f�rence pour les doublons
	--D�termine la condition du LEFT JOIN (utile pour les cas o� la colonne cl� est Num�ro�v�nementParent puisqu'il peut �tre pr�sent plusieurs fois sans �tre un doublon)
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @table AND COLUMN_NAME = 'Num�ro�v�nement')
    BEGIN
        SET @keyColumn = 'Num�ro�v�nement';
		SET @onJoin = @table + '.' + 'Num�ro�v�nement' + ' = ' + @tempTable + '.' + 'Num�ro�v�nement';
    END
    ELSE IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @table AND COLUMN_NAME = 'Num�ro�v�nementParent')
    BEGIN
		IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @table AND COLUMN_NAME = 'DateD�but')
		BEGIN
			SET @dateColumn = 'DateD�but';
		END
		ELSE IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @table AND COLUMN_NAME = 'DateD�butCSQ')
		BEGIN
			SET @dateColumn = 'DateD�butCSQ';
		END
		ELSE IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @table AND COLUMN_NAME = 'Date')
		BEGIN
			SET @dateColumn = 'Date';
		END
		ELSE
		BEGIN
			RAISERROR('Erreur : La table %s ne contient ni la colonne ''DateD�but'' ni la colonne ''DateD�butCSQ'' ni la colonne ''Date''.', 16, 1, @table);
		END
        SET @keyColumn = 'Num�ro�v�nementParent';
		SET @onJoin = @table + '.' + @keyColumn + ' = ' + @tempTable + '.' + @keyColumn + ' AND ' + @table + '.' + @dateColumn + ' = ' + @tempTable + '.' + @dateColumn;
    END
	ELSE
    BEGIN
        RAISERROR('Erreur : La table %s ne contient ni la colonne ''Num�ro�v�nement'' ni la colonne ''Num�ro�v�nementParent''.', 16, 1, @table);
    END

	--V�rifie que la table temporaire existe
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @tempTable AND TABLE_TYPE = 'BASE TABLE')
	BEGIN
		--Ins�re les donn�es dans la premi�re table temporaire
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

		--Ins�re les donn�es dans la table temporaire en ignorant les doublons avec un SELECT DISTINCT
		SET @sql = '
		INSERT INTO ' + @tempTable + '
		SELECT DISTINCT *
		FROM DataCleaner;';

		EXEC sp_executesql @sql;

		--Cr�e une s�rie de condition "�gale �" qui va permettre de v�rifier si une donn�es a �t� modifi�e dans une ligne de donn�e
		SELECT @columnsList = STRING_AGG(CAST(@table + '.' + name + ' = ' + @tempTable + '.' + name AS NVARCHAR(MAX)), ' OR ')
		FROM sys.columns
		WHERE object_id = OBJECT_ID(@table);

		--R�cup�re la valeur d'une colonne lorsque la valeur re�ue diff�re de la valeur dans la base de donn�es
		SELECT @columnsToInsertCase = STRING_AGG(
            'CASE WHEN [' + @table + '].[' + name + '] <> [' + @tempTable + '].[' + name + '] THEN [' + @tempTable + '].[' + name + '] ELSE NULL END AS [' + name + ']', 
            ', '
        ), @columnsToInsert = STRING_AGG(CAST(@tempTable + '.' + name AS NVARCHAR(MAX)), ', ')
        FROM sys.columns
        WHERE object_id = OBJECT_ID(@table) AND name <> @keyColumn AND name <> 'Matricule';

		--Cr�e une s�rie de condition "Diff�rent de" qui va permettre de v�rifier si une donn�es a �t� modifi�e dans une ligne de donn�e
        SELECT @updateCondition = STRING_AGG(
            '[' + @table + '].[' + name + '] <> [' + @tempTable + '].[' + name + ']', 
            ' OR '
        )
        FROM sys.columns
        WHERE object_id = OBJECT_ID(@table);

		--Ins�re les modifications dans la table de modifications correspondante lorsqu'il y a une modification d'une donn�e (1)
		--Ins�re les informations principales dans la table Modifications lorsqu'il y a une modification (2)
        SET @sql = '
        INSERT INTO ' + @modTable + ' (' + @columnsToInsert + ', ' + @keyColumn + ', Matricule, StatutDonn�e)
        SELECT ' + @columnsToInsertCase + ', ' + @tempTable + '.' + @keyColumn + ', ' + @tempTable + '.Matricule' + ', ''Modifi�''
        FROM ' + @tempTable + '
        LEFT JOIN ' + @table + ' ON ' + @onJoin + '
        WHERE ' + @table + '.' + @keyColumn + ' IS NOT NULL
          AND (' + @updateCondition + ')
		  
		INSERT INTO Modifications (NomTable, Num�ro�v�nement, StatutDonn�e)
		SELECT ''' + @table + ''', ' + @tempTable + '.' + @keyColumn + ', ''Modifi�''
		FROM ' + @tempTable + '
		LEFT JOIN ' + @table + ' ON ' + @onJoin + '
		WHERE ' + @table + '.' + @keyColumn + ' IS NOT NULL
          AND (' + @updateCondition + ');';

        EXEC sp_executesql @sql;

		--Ins�re les informations dans la table de modifications correspondante lorsqu'il y a une nouvelle donn�e
		SET @sql = '
		INSERT INTO ' + @modTable + ' (' + REPLACE(@columns, @tempTable, @table) + ', StatutDonn�e)
		SELECT ' + @columns + ', ''Nouveau''
		FROM ' + @tempTable + '
		LEFT JOIN ' + @table + ' ON ' + @onJoin + '
		WHERE NOT EXISTS (
			SELECT 1
			FROM ' + @table + '
			WHERE ' + @table + '.' + @keyColumn + ' IS NOT NULL
		);';

		EXEC sp_executesql @sql;

		--Ins�re les informations principales dans la table Modifications lorsqu'il y a une nouvelle donn�e
		SET @sql = '
		INSERT INTO Modifications (NomTable, Num�ro�v�nement, StatutDonn�e)
		SELECT ''' + @table + ''', ' + @tempTable + '.' + @keyColumn + ', ''Nouveau''
		FROM ' + @tempTable + '
		LEFT JOIN ' + @table + ' ON ' + @onJoin + '
		WHERE NOT EXISTS (
			SELECT 1
			FROM ' + @table + '
			WHERE ' + @table + '.' + @keyColumn + ' IS NOT NULL' + ' AND (' + @columnsList + ')
		);';

		EXEC sp_executesql @sql;

		--Supprime les lignes de la base de donn�es qui ont une modification disponible dans la table temporaire
		SET @sql = '
		DELETE FROM ' + @table + '
		WHERE EXISTS (
			SELECT 1
			FROM ' + @tempTable + '
			WHERE ' + @onJoin + ' AND (' + @columnsList + ')
		);';

		EXEC sp_executesql @sql;

		--Ins�re les nouvelles donn�es ainsi que les donn�es modifi�es dans la base de donn�es
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

		--Supprime la table temporaire interm�diaire
		SET @sql = 'DROP TABLE IF EXISTS DataCleaner;';
		EXEC sp_executesql @sql;
	END

	FETCH NEXT FROM table_cursor INTO @table;
END

--D�salloue le curseur
CLOSE table_cursor;
DEALLOCATE table_cursor;

-- Conserve la date  heure de la derni�re mise � jour
TRUNCATE TABLE BDIP_DateMAJ
INSERT INTO BDIP_DateMAJ
SELECT DateMAJ = CONVERT(DATETIME2(0), SYSDATETIME())
