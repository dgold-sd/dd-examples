**SQL Server integration example**


The default table from which counters are drawn is the sys.dm_os_performance_counters table. The Datadog-SQL server check also supports sys.dm_os_wait_stats, sys.dm_os_memory_clerks, and sys.dm_io_virtual_file_stats.

If you want to collect counters from other tables, you can use stored procedures. The GetOSLatchStats file has a procedure that will collect metrics from sys.dm_os_latch_stats. 
