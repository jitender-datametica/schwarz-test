EXECUTE IMMEDIATE
$$
DECLARE
       UpdtSTMT  STRING;
       OUTPUT STRING DEFAULT 'SUCCESS';
       c1 CURSOR FOR select TABLE_SCHEMA
                          , TABLE_NAME 
                       from INFORMATION_SCHEMA.TABLES
                      where TABLE_SCHEMA in ( 'META', 'CORE_REL', 'CORE_DIM', 'CORE_APP_FRAUD_DETECTION')
                        and TABLE_NAME NOT LIKE 'V%'
                        and TABLE_NAME NOT LIKE 'T_DV_%'
                        and TABLE_NAME NOT LIKE '%BACKUP%'
                        and TABLE_NAME NOT LIKE 'T_TF_%'
                        and TABLE_NAME NOT LIKE 'T_TS_%'
                        and TABLE_NAME NOT LIKE '%TEST_2%'   
                      order by TABLE_SCHEMA
                          , TABLE_NAME;

BEGIN
  BEGIN

   OPEN c1;
   FOR rec IN c1 DO
       UpdtSTMT := 'MERGE INTO etl.T_REC_CNT_2 AS T
                    USING ( select '''||rec.TABLE_SCHEMA||'.'||REC.TABLE_NAME||''' AS TBL_NAME
                                 , CURRENT_DATE as BUS_DT
                                 , COUNT(1) AS CNT
                              from '||rec.TABLE_SCHEMA||'.'||REC.TABLE_NAME||' as src
                          ) as S                 
   ON T.TBL_NAME = S.TBL_NAME
  AND T.BUS_DT = S.BUS_DT
 WHEN MATCHED THEN
         UPDATE SET 
                TBL_REC_CNT    = S.cnt,
                DWH_UPDATED_TMSP = CURRENT_TIMESTAMP
 WHEN NOT MATCHED THEN INSERT ( BUS_DT, TBL_NAME, TBL_REC_CNT, DWH_CREATED_TMSP, DWH_UPDATED_TMSP) 
                       VALUES ( S.BUS_DT, S.TBL_NAME, S.CNT, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP) 
 ;';
       
       EXECUTE IMMEDIATE :UpdtSTMT;
   END FOR;
   EXCEPTION  
   WHEN OTHER THEN
        OUTPUT := SQLCODE || ': ' || SQLERRM;
   END;
   RETURN :OUTPUT;
END;   
$$;
