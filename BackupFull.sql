USE master;
GO
DECLARE @BackupFile NVARCHAR(500);
DECLARE @DatabaseName NVARCHAR(100);

DECLARE db_cursor CURSOR FOR
SELECT name FROM sys.databases WHERE database_id > 4 AND state_desc = 'ONLINE';

OPEN db_cursor;
FETCH NEXT FROM db_cursor INTO @DatabaseName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @BackupFile = 'D:\SQLBackups\Full\' + @DatabaseName + '_FULL_' + FORMAT(GETDATE(), 'yyyyMMdd_HHmm') + '.bak';

    BACKUP DATABASE @DatabaseName
    TO DISK = @BackupFile
    WITH CHECKSUM, INIT, COMPRESSION, STATS = 10;

    FETCH NEXT FROM db_cursor INTO @DatabaseName;
END

CLOSE db_cursor;
DEALLOCATE db_cursor;
