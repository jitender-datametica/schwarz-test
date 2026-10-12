CREATE OR REPLACE TASK DBP_MSI_VIEW2.TASK_SUSPEND_DYNAMICTABLES
	WAREHOUSE=WH_UTILITY_XS
	SCHEDULE='USING CRON 30 20 * * * Europe/Berlin'
	AS EXECUTE IMMEDIATE
  $$
  DECLARE
  table_cursor CURSOR FOR
   SELECT table_schema || '.' || table_name AS dt_table FROM information_schema.tables WHERE table_schema = 'DBP_MSI_VIEW2' AND is_dynamic ='YES'  ;
   res VARCHAR DEFAULT '';
BEGIN
  FOR var IN table_cursor DO
    res:= var.dt_table;
    ALTER DYNAMIC TABLE IDENTIFIER(:res) SUSPEND;
  END FOR;
    RETURN 'Dynamic Tables SUSPEND' ;
END;
  $$;