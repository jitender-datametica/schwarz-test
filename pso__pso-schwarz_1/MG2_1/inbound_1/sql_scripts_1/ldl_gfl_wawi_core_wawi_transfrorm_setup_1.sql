EXECUTE IMMEDIATE
$$
DECLARE
       UpdtSTMT  STRING;
       HistSTMT  STRING;
       OUTPUT STRING DEFAULT 'SUCCESS';
       c1 CURSOR FOR select SOURCE_TABLE_NAME from ETL.WAWI_CONTROL_TABLE_1;

BEGIN
  BEGIN
   HistSTMT := 'MERGE INTO ETL.WAWI_CONTROL_TABLE_HIST_1 AS T
                USING (SELECT (SELECT Coalesce( max(LOAD_ID), 0) + 1 FROM ETL.WAWI_CONTROL_TABLE_HIST_1) AS LOAD_ID
                            , SOURCE_TABLE_NAME
                            , BEGIN_TMSP
                            , END_TMSP
                            , REC_COUNT
                            , SOURCE_STATUS
                            , UPDATED_TMSP FROM ETL.WAWI_CONTROL_TABLE_1) AS S
                   ON T.SOURCE_TABLE_NAME = S.SOURCE_TABLE_NAME
                  AND T.BEGIN_TMSP = S.BEGIN_TMSP
                  AND T.CREATED_TMSP = S.UPDATED_TMSP
                 WHEN NOT MATCHED THEN
                      INSERT( LOAD_ID, SOURCE_TABLE_NAME, BEGIN_TMSP, END_TMSP, REC_COUNT, SOURCE_STATUS, CREATED_TMSP )
                      VALUES( S.LOAD_ID, S.SOURCE_TABLE_NAME, S.BEGIN_TMSP, S.END_TMSP, S.REC_COUNT, S.SOURCE_STATUS, S.UPDATED_TMSP);';
   EXECUTE IMMEDIATE :HistSTMT;

   OPEN c1;    
   FOR rec IN c1 DO
       UpdtSTMT := 'MERGE INTO ETL.WAWI_CONTROL_TABLE_1 AS T
USING ( select flt.SOURCE_TABLE_NAME as src_name,
               MIN( src.EXTRACTION_TMSP) as b_tmsp,
               MAX( src.EXTRACTION_TMSP) as e_tmsp,
               COUNT(1) AS CNT
          from '||rec.SOURCE_TABLE_NAME||' as src
          join ETL.WAWI_CONTROL_TABLE_1 as flt
            on flt.SOURCE_TABLE_NAME = '''||rec.SOURCE_TABLE_NAME||''' '||'
           and src.EXTRACTION_TMSP > flt.END_TMSP
           AND flt.SOURCE_STATUS = ''A''
         group by src_name
        having b_tmsp <> e_tmsp) as S                 
   ON T.SOURCE_TABLE_NAME = S.src_name
 WHEN MATCHED THEN
         UPDATE SET SOURCE_TABLE_NAME = S.src_name,
                    BEGIN_TMSP        = S.b_tmsp,
                    END_TMSP          = S.e_tmsp,
                    REC_COUNT         = S.cnt,
                    UPDATED_TMSP      = CURRENT_TIMESTAMP;';
       
       EXECUTE IMMEDIATE :UpdtSTMT;
   END FOR;
   EXCEPTION  
   WHEN OTHER THEN
        OUTPUT := SQLCODE || ': ' || SQLERRM;
   END;
   RETURN :OUTPUT;
END;   
$$;
