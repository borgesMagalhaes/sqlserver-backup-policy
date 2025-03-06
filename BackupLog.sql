USE master;
GO
DECLARE @BackupFile NVARCHAR(500);
DECLARE @DatabaseName NVARCHAR(100);

DECLARE db_cursor CURSOR FOR
SELECT name FROM sys.databases WHERE database_id > 4 AND state_desc = 'ONLINE' AND recovery_model_desc = 'FULL';

OPEN db_cursor;
FETCH NEXT FROM db_cursor INTO @DatabaseName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @BackupFile = 'D:\SQLBackups\Log\' + @DatabaseName + '_LOG_' + FORMAT(GETDATE(), 'yyyyMMdd_HHmm') + '.trn';

    BACKUP LOG @DatabaseName
    TO DISK = @BackupFile
    WITH CHECKSUM, INIT, COMPRESSION, STATS = 5;

    FETCH NEXT FROM db_cursor INTO @DatabaseName;
END

CLOSE db_cursor;
DEALLOCATE db_cursor;
