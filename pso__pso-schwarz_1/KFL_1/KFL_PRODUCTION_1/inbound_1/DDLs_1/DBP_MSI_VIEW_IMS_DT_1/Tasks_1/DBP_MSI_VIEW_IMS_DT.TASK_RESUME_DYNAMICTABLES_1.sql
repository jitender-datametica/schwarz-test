CREATE OR REPLACE TASK DBP_MSI_VIEW_IMS_DT.TASK_RESUME_DYNAMICTABLES
	WAREHOUSE=WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS
	SCHEDULE='USING CRON 0 06 * * * Europe/Berlin'
	AS EXECUTE IMMEDIATE
  $$
  DECLARE
  table_cursor CURSOR FOR
   SELECT table_schema || '.' || table_name AS dt_table FROM information_schema.tables WHERE table_schema = 'DBP_MSI_VIEW_IMS_DT' AND is_dynamic ='YES' ;
   
   res VARCHAR DEFAULT '';
BEGIN
  FOR var IN table_cursor DO
    res:= var.dt_table;
    ALTER DYNAMIC TABLE IDENTIFIER(:res) RESUME;
  END FOR;
    RETURN 'Dynamic Tables resume' ;
END;
  $$;