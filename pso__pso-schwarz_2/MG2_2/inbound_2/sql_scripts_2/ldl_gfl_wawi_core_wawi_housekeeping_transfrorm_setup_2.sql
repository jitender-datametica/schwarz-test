alter session set TIMESTAMP_NTZ_OUTPUT_FORMAT='YYYY-MM_2-DD HH24:MI:SS.FF6';
alter session set TIMESTAMP_LTZ_OUTPUT_FORMAT='YYYY-MM_2-DD HH24:MI:SS.FF6';
EXECUTE IMMEDIATE
$$
DECLARE
       Del1STMT  STRING;
       Del2STMT  STRING;
       OUTPUT STRING DEFAULT 'SUCCESS';


       c1 CURSOR FOR select load_id, source_table_name, begin_tmsp, end_tmsp from ETL.WAWI_CONTROL_TABLE_HIST_2
                     where begin_tmsp<=DATE_TRUNC(month,current_date-32)
                     and end_tmsp <=DATE_TRUNC(month,current_date-32);

BEGIN
  BEGIN

   OPEN c1;    
   FOR rec IN c1 DO

       Del1STMT := 'DELETE FROM '||rec.source_table_name|| ' where extraction_tmsp between '''|| rec.begin_tmsp||''' and '''|| rec.end_tmsp||''' ;';
       Del2STMT := 'DELETE FROM ETL.WAWI_CONTROL_TABLE_HIST_2 where load_id='|| rec.load_id||' and source_table_name='''||rec.source_table_name||''';';
       insert into etl.test_tp values (:Del1STMT);
       EXECUTE IMMEDIATE :Del1STMT;
       EXECUTE IMMEDIATE :Del2STMT;
   END FOR;
   EXCEPTION  
   WHEN OTHER THEN
        OUTPUT := SQLCODE || ': ' || SQLERRM;
   END;
   RETURN :OUTPUT;
END;   
$$;
