CREATE OR REPLACE TASK DBP_MSI_VIEW_SCM.TASK_RESUME_DYNAMICTABLES
	WAREHOUSE=WH_UTILITY_XS
	SCHEDULE='USING CRON 50 06 * * MON-FRI Europe/Berlin'
	AS EXECUTE IMMEDIATE
  $$
  DECLARE
  table_cursor CURSOR FOR
   select table_schema || '.' || table_name as dt_table from information_schema.tables where table_schema = 'DBP_MSI_VIEW_SCM' AND is_dynamic ='YES' ;
   res VARCHAR DEFAULT '';
BEGIN
  FOR var in table_cursor DO
    res:= var.dt_table;
    ALTER DYNAMIC TABLE IDENTIFIER(:res) RESUME;
  END FOR;
    RETURN 'Dynamic Tables resume' ;
END;
  $$;
