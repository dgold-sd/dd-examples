CREATE PROCEDURE [dbo].[GetOSLatchStats]
AS
BEGIN

  -- Remove row counts from result sets
  SET NOCOUNT ON;

  -- Create a temporary table per integration instructions

  CREATE TABLE #Datadog
  (
    [metric] VARCHAR(255) NOT NULL,
    [type] VARCHAR(50) NOT NULL,
    [value] FLOAT NOT NULL,
    [tags] VARCHAR(255)
  );

  SELECT 
	  latch_class,
      ISNULL(wait_time_ms,0) AS wait_time_ms
  into #tempresult
  FROM sys.dm_os_latch_stats latchstats
  WHERE latchstats.latch_class in ('ACCESS_METHODS_DATASET_PARENT',
									'BUFFER',
									'LOG_MANAGER',
									'NESTING_TRANSACTION_READONLY',
									'ACCESS_METHODS_ACCESSOR_CACHE')
  


  -- Remove the units from our custom metrics and insert them into the table #Datadog

  INSERT INTO #Datadog(metric, type, value, tags) VALUES
    ('sqlserver.latch.ACCESS_METHODS_DATASET_PARENT_wait_time_ms', 'gauge', (SELECT ISNULL(wait_time_ms,0) FROM #tempresult WHERE latch_class = 'ACCESS_METHODS_DATASET_PARENT'), 'db:master'),
    ('sqlserver.latch.BUFFER_wait_time_ms', 'gauge', (SELECT wait_time_ms FROM #tempresult WHERE latch_class = 'BUFFER'), 'db:master'),
    ('sqlserver.latch.LOG_MANAGER_wait_time_ms', 'gauge', (SELECT wait_time_ms FROM #tempresult WHERE latch_class = 'LOG_MANAGER'), 'db:master'),
    ('sqlserver.latch.NESTING_TRANSACTION_READONLY_wait_time_ms', 'gauge', (SELECT wait_time_ms FROM #tempresult WHERE latch_class = 'NESTING_TRANSACTION_READONLY'), 'db:master'),
    ('sqlserver.latch.ACCESS_METHODS_ACCESSOR_CACHE_wait_time_ms', 'gauge', (SELECT wait_time_ms FROM #tempresult WHERE latch_class = 'ACCESS_METHODS_ACCESSOR_CACHE'), 'db:master')

	-- Return the table
	SELECT * FROM #Datadog;

END