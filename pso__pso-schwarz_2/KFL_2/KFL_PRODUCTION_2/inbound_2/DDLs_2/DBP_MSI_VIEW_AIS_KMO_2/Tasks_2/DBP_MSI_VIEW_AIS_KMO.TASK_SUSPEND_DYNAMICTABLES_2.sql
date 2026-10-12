CREATE OR REPLACE TASK DBP_MSI_VIEW_AIS_KMO.TASK_SUSPEND_DYNAMICTABLES
WAREHOUSE=WH_UTILITY_XS
SCHEDULE='USING CRON 30 20 * * * Europe/Berlin'
AS EXECUTE IMMEDIATE
  $$
  DECLARE
  table_cursor CURSOR FOR
   select table_schema || '.' || table_name as dt_table from information_schema.tables where table_schema = 'DBP_MSI_VIEW_AIS_KMO' AND IS_DYNAMIC ='YES'  ;
   res VARCHAR DEFAULT '';
BEGIN
  FOR var in TABLE_CURSOR DO
    res:= var.dt_table;
    ALTER DYNAMIC TABLE IDENTIFIER(:res) SUSPEND;
  END FOR;
    RETURN 'Dynamic Tables SUSPEND' ;
END;
  $$;