DECLARE @table NVARCHAR(MAX);
DECLARE @tempTable NVARCHAR(MAX);
DECLARE @columns NVARCHAR(MAX) = '';
DECLARE @columnsList NVARCHAR(MAX) = '';
DECLARE @filePath NVARCHAR(MAX);
DECLARE @sql NVARCHAR(MAX);


DECLARE table_cursor CURSOR FOR
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE 'BDIP_%' AND TABLE_TYPE = 'BASE TABLE';

OPEN table_cursor;

FETCH NEXT FROM table_cursor INTO @table;

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @tempTable = 'temp' + @table;

	SELECT @filePath = FilePath
	FROM FileMapping
	WHERE TableName = @table;

	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @tempTable AND TABLE_TYPE = 'BASE TABLE')
	BEGIN
		SET @sql = '
		BULK INSERT dbo.' + @tempTable + '
		FROM ''' + @filePath + '''
		WITH (
			FIELDTERMINATOR = ''\'',
			ROWTERMINATOR = ''\n'',
			FIRSTROW = 2,
			CODEPAGE = ''65001''
		);';

		EXEC sp_executesql @sql;

		SELECT @columns = STRING_AGG(CAST(@tempTable + '.' + name AS NVARCHAR(MAX)), ', ')
		FROM sys.columns
		WHERE object_id = OBJECT_ID(@table);

		SELECT @columnsList = STRING_AGG(CAST(@table + '.' + name + ' = ' + @tempTable + '.' + name AS NVARCHAR(MAX)), ' AND ')
		FROM sys.columns
		WHERE object_id = OBJECT_ID(@table);

		SET @sql = '
		INSERT INTO ' + @table + ' (' + REPLACE(@columns, @tempTable, @table) + ')
		SELECT ' + @columns + '
		FROM ' + @tempTable + '
		LEFT JOIN ' + @table + ' ON ' + @columnsList + '
		WHERE NOT EXISTS (
			SELECT 1
			FROM ' + @table + '
			WHERE ' + @table + '.Matricule = ' + @tempTable + '.Matricule
		);';

		EXEC sp_executesql @sql;

		SET @sql = 'TRUNCATE TABLE ' + @tempTable;
		EXEC sp_executesql @sql;
	END

	FETCH NEXT FROM table_cursor INTO @table;
END

CLOSE table_cursor;
DEALLOCATE table_cursor;

-- Conserve la date  heure de la dernière mise à jour
TRUNCATE TABLE BDIP_DateMAJ
INSERT INTO BDIP_DateMAJ
SELECT DateMAJ = CONVERT(DATETIME2(0), SYSDATETIME())
