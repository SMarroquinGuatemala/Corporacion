--Checking for Strange Client Settings with sys.dm_exec_sessions
SELECT *
FROM sys.dm_exec_sessions
WHERE is_user_process = 1 AND
(ansi_nulls = 0
OR ansi_padding = 0 
OR ansi_warnings = 0 
OR arithabort = 0 
OR concat_null_yields_null = 0 
OR quoted_identifier = 0)
order by login_time desc