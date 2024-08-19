DECLARE @table NVARCHAR(MAX);
DECLARE @tempTable NVARCHAR(MAX);
DECLARE @columns NVARCHAR(MAX) = '';
DECLARE @columnsList NVARCHAR(MAX) = '';
DECLARE @sql NVARCHAR(MAX);
DECLARE @filePath NVARCHAR(MAX);


DECLARE table_cursor CURSOR FOR
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE 'BD_%' AND TABLE_TYPE = 'BASE TABLE';

OPEN table_cursor;

FETCH NEXT FROM table_cursor INTO @table;

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @tempTable = 'temp' + @table;

	SELECT @filePath = FilePath
	FROM FileMapping
	WHERE TableName = @table;

	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @tempTable AND TABLE_TYPE = 'BASE TABLE')
    AND @filePath IS NOT NULL
	BEGIN
		SET @sql = '
		INSERT INTO ' + @tempTable + '
        SELECT * FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',
        ''Excel 12.0;Database=''' + @filePath + ''';HDR=YES'',
        ''SELECT * FROM [Sheet1$]'');';

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