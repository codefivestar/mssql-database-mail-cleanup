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
	
	EXEC sysmail_delete_mailitems_sp @sent_before   = @DeleteBeforeDate;
	EXEC sysmail_delete_log_sp       @logged_before = @DeleteBeforeDate;

