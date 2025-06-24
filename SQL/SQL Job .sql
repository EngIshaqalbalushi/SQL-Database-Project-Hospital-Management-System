


USE msdb;
GO

-- Step 1: Create the SQL Agent Job
EXEC sp_add_job  
    @job_name = N'Daily_MasterDB_Backup',
    @enabled = 1,
    @description = N'Daily full backup of the master database at 2:00 AM',
    @owner_login_name = N'sa';

-- Step 2: Add the backup step
EXEC sp_add_jobstep  
    @job_name = N'Daily_MasterDB_Backup',
    @step_name = N'Backup Master DB',
    @subsystem = N'TSQL',
    @command = N'
        BACKUP DATABASE [master]
        TO DISK = N''C:\Users\Codeline\Desktop\Full stack\day 47\master_backup.bak''
        WITH FORMAT, INIT, NAME = ''Master DB Full Backup'', STATS = 10;
    ',
    @retry_attempts = 1,
    @retry_interval = 5;

-- Step 3: Create the schedule (daily at 2:00 AM)
EXEC sp_add_schedule  
    @schedule_name = N'Daily_2AM_Schedule',
    @freq_type = 4,               -- Daily
    @freq_interval = 1,          -- Every day
    @active_start_time = 020000; -- 2:00 AM

-- Step 4: Attach the schedule to the job
EXEC sp_attach_schedule  
    @job_name = N'Daily_MasterDB_Backup',
    @schedule_name = N'Daily_2AM_Schedule';

-- Step 5: Register the job with SQL Server Agent
EXEC sp_add_jobserver  
    @job_name = N'Daily_MasterDB_Backup',
    @server_name = N'(LOCAL)';
-- Check if SQL Server Agent is running

EXEC xp_servicecontrol 'QUERYSTATE', 'SQLServerAgent';

IF EXISTS (SELECT 1 FROM msdb.dbo.sysjobs WHERE name = 'Daily_MasterDB_Backup')
BEGIN
    EXEC sp_delete_job @job_name = 'Daily_MasterDB_Backup';
END




--https://search.brave.com/search?q=job+sql+server+code&summary=1&conversation=8e8ea9c0eb53cd71d24a0d