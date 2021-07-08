----------------------------------------------------------------------------------------------------------
-- Author      : Hidequel Puga
-- Date        : 2021-07-08
-- Description : MSSQL Database mail cleanup procedures
----------------------------------------------------------------------------------------------------------

DECLARE @DeleteBeforeDate DATETIME; 
    SET @DeleteBeforeDate = DATEADD(d,-30, GETDATE());
	
	EXEC sysmail_delete_mailitems_sp @sent_before   = @DeleteBeforeDate;
	EXEC sysmail_delete_log_sp       @logged_before = @DeleteBeforeDate;


fecha más antigua : 2019-05-02 11:24:59.217

fecha más reciente : 2021-07-06 05:57:37.497