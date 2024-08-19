-- Déclaration des variables
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
    -- Préparer la commande TRUNCATE TABLE
    SET @sql = 'TRUNCATE TABLE ' + QUOTENAME(@tableName) + ';';

    -- Exécuter la commande
    EXEC sp_executesql @sql;

    -- Fetch suivant
    FETCH NEXT FROM table_cursor INTO @tableName;
END

-- Fermer et désallouer le curseur
CLOSE table_cursor;
DEALLOCATE table_cursor;
