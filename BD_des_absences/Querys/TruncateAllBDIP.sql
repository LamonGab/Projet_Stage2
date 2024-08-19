-- D�claration des variables
DECLARE @tableName NVARCHAR(MAX);
DECLARE @sql NVARCHAR(MAX);

-- Curseur pour parcourir les tables
DECLARE table_cursor CURSOR FOR
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE 'BDIP_%' AND TABLE_TYPE = 'BASE TABLE';

-- Ouvrir le curseur
OPEN table_cursor;

-- Fetch initial
FETCH NEXT FROM table_cursor INTO @tableName;

-- Boucle sur toutes les tables
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Pr�parer la commande TRUNCATE TABLE
    SET @sql = 'TRUNCATE TABLE ' + QUOTENAME(@tableName) + ';';

    -- Ex�cuter la commande
    EXEC sp_executesql @sql;

    -- Fetch suivant
    FETCH NEXT FROM table_cursor INTO @tableName;
END

-- Fermer et d�sallouer le curseur
CLOSE table_cursor;
DEALLOCATE table_cursor;
