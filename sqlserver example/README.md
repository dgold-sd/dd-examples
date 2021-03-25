# **SQL Server integration example**

## Sample configuration file

The **sqlserver.d-conf.yaml** file should be added as conf.d/sqlserver.d/conf.yaml or through the Windows Agent Manager. It contains examples of custom metrics that can be collected, how to collect metrics from the stored procedure (see below), as well as the configuration for Logs collection from the MSSQL ERRORLOG file. 

It also contains a section to collect logs from test files (C:\test\*.out). This is used for my demo environment to add event logs for dashboards since my demo SQL Server instance does not always generate them in the ERRORLOG file. This can be ignored in a production environment.


## Stored Procedures

The default table from which counters are drawn is the sys.dm_os_performance_counters table. The Datadog-SQL server check also supports sys.dm_os_wait_stats, sys.dm_os_memory_clerks, and sys.dm_io_virtual_file_stats.

If you want to collect counters from other tables, you can use stored procedures. The **GetOSLatchStats.sql** file has a procedure that will collect metrics from sys.dm_os_latch_stats. Once this is added to the database, the following metrics are collected:
- sqlserver.latch.BUFFER_wait_time_ms
- sqlserver.latch.LOG_MANAGER_wait_time_ms
- sqlserver.latch.NESTING_TRANSACTION_READONLY_wait_time_ms
- sqlserver.latch.ACCESS_METHODS_ACCESSOR_CACHE_wait_time_ms
- sqlserver.latch.ACCESS_METHODS_DATASET_PARENT_wait_time_ms

## Dashboard example

An example dashboard export is included - **SQLServer-Overview--2021-03-25.json**. 

For Datadog SEs, you can access this in the demo environment [here](https://app.datadoghq.com/dashboard/aum-ssg-i9v/sqlserver-overview-dsg)

## Documentation Links:
- [Collecting metrics from DMV](https://docs.datadoghq.com/integrations/guide/collect-sql-server-custom-metrics/#collecting-metrics-from-dmv)
- [Collecting metrics from a custom stored procedure](https://docs.datadoghq.com/integrations/guide/collect-sql-server-custom-metrics/#collecting-metrics-from-a-custom-procedure)
