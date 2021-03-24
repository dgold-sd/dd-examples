**SQL Server integration example**


The default table from which counters are drawn is the sys.dm_os_performance_counters table. The Datadog-SQL server check also supports sys.dm_os_wait_stats, sys.dm_os_memory_clerks, and sys.dm_io_virtual_file_stats.

If you want to collect counters from other tables, you can use stored procedures. The GetOSLatchStats file has a procedure that will collect metrics from sys.dm_os_latch_stats. Once this is added to the database, the following metrics are collected:
    sqlserver.latch.BUFFER_wait_time_ms
    sqlserver.latch.LOG_MANAGER_wait_time_ms
    sqlserver.latch.NESTING_TRANSACTION_READONLY_wait_time_ms
    sqlserver.latch.ACCESS_METHODS_ACCESSOR_CACHE_wait_time_ms
    sqlserver.latch.ACCESS_METHODS_DATASET_PARENT_wait_time_ms
