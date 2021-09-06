----------------------------------------------------------------------------------------------------------
-- Author      : Hidequel Puga
-- Date        : 2021-07-08
-- Description : MSSQL Database mail cleanup procedures
----------------------------------------------------------------------------------------------------------
-- Ref         : https://www.mssqltips.com/sqlservertip/1732/sql-server-database-mail-cleanup-procedures/
--               https://dbamohsin.wordpress.com/2012/07/06/shrink-msdb-database/
--               https://blog.sqlauthority.com/2016/11/25/sql-server-stop-growing-msdb-database-removing-sysmail_mailitems-history/
----------------------------------------------------------------------------------------------------------

USE [msdb]
GO

DECLARE @DeleteBeforeDate DATETIME; 
    SET @DeleteBeforeDate = DATEADD(d,-30, GETDATE());

-- delete from sysmail_attachments
DELETE FROM [dbo].[sysmail_attachments] WHERE last_mod_date < @DeleteBeforeDate;

-- delete from sysmail_send_retries
DELETE FROM [dbo].[sysmail_send_retries] WHERE last_send_attempt_date < @DeleteBeforeDate;

-- delete from sysmail_allitems
EXEC sysmail_delete_mailitems_sp @sent_before   = @DeleteBeforeDate;

-- delete from sysmail_log
EXEC sysmail_delete_log_sp       @logged_before = @DeleteBeforeDate;

DBCC SHRINKDATABASE(N'msdb')
DBCC SHRINKFILE (N'MSDBData' , 0, truncateonly)
