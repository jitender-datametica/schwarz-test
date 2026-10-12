
BEGIN
  DECLARE Del1STMT STRING;
  DECLARE Del2STMT STRING;
  DECLARE OUTPUT STRING DEFAULT 'SUCCESS';

  BEGIN
    
    FOR rec IN (
      SELECT
        load_id,
        source_table_name,
        begin_tmsp,
        end_tmsp
      FROM `ldl_data_production_etl.wawi_control_table_hist_2`
      WHERE begin_tmsp <= DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 32 DAY), MONTH)
        AND end_tmsp   <= DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 32 DAY), MONTH)
    )
    DO
      
      SET Del1STMT = '''delete from '''||rec.source_table_name|| ''' where extraction_tmsp between '''|| rec.begin_tmsp||''' and '''|| rec.end_tmsp||''' ;''';
      
      SET Del2STMT = '''delete from ldl_data_production_etl.wawi_control_table_hist_2 where load_id='''|| rec.load_id||''' and source_table_name='''||rec.source_table_name||''';''';

      
      INSERT INTO `ldl_data_production_etl.test_tp` (stmt_text)
      VALUES (Del1STMT);

      
      EXECUTE IMMEDIATE Del1STMT;
      EXECUTE IMMEDIATE Del2STMT;
    END FOR;

  EXCEPTION WHEN ERROR THEN
    SET OUTPUT = @@error.message;
  END;

  
  SELECT OUTPUT AS result;
END;
