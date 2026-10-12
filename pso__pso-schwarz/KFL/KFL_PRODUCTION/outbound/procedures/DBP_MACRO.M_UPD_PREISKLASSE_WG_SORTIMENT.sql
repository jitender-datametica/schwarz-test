CREATE OR REPLACE PROCEDURE dbp_macro.m_upd_preisklasse_wg_sortiment(IN S_WG_ID FLOAT64, IN S_PL_1 FLOAT64, IN S_PL_2 FLOAT64, IN S_PL_3 FLOAT64, IN S_PL_4 FLOAT64, IN S_PL_5 FLOAT64, IN S_PL_6 FLOAT64, IN S_PL_7 FLOAT64, IN S_PL_8 FLOAT64, IN S_PL_9 FLOAT64, IN S_PL_10 FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql_stmt  =  '''UPDATE dbp_data.ts_sortiment_preisklasse_uwg 
SET  preislage_1 = ROUND(CAST(@S_PL_1 AS NUMERIC), 2),  
     preislage_2 = ROUND(CAST(@S_PL_2 AS NUMERIC), 2),  
     preislage_3 = ROUND(CAST(@S_PL_3 AS NUMERIC), 2),  
     preislage_4 = ROUND(CAST(@S_PL_4 AS NUMERIC), 2),  
     preislage_5 = ROUND(CAST(@S_PL_5 AS NUMERIC), 2),  
     preislage_6 = ROUND(CAST(@S_PL_6 AS NUMERIC), 2),  
     preislage_7 = ROUND(CAST(@S_PL_7 AS NUMERIC), 2),  
     preislage_8 = ROUND(CAST(@S_PL_8 AS NUMERIC), 2),  
     preislage_9 = ROUND(CAST(@S_PL_9 AS NUMERIC), 2),  
     preislage_10 = ROUND(CAST(@S_PL_1 AS NUMERIC), 2) 
  FROM (SELECT DISTINCT V01.kl_wg_id,    V03.kl_uwg_id   
  FROM dbp_view.v_kl_wg_nielsen AS V01    
  INNER JOIN dbp_view.v_kl_owg_nielsen AS V02 
  ON V01.kl_wg_id = V02.kl_wg_id    
  INNER JOIN dbp_view.v_kl_uwg_nielsen AS V03 
  ON V02.kl_owg_id = V03.kl_owg_id   WHERE V01.kl_wg_id = @S_WG_ID) AS src 
  WHERE ts_sortiment_preisklasse_uwg.kl_uwg_id = src.kl_uwg_id ''';

EXECUTE IMMEDIATE (sql_stmt) USING S_PL_1 AS S_PL_1,  S_PL_2 AS S_PL_2,  S_PL_3 AS S_PL_3,  S_PL_4 AS S_PL_4,  S_PL_5 AS S_PL_5,  S_PL_6 AS S_PL_6,  S_PL_7 AS S_PL_7,  S_PL_8 AS S_PL_8,  S_PL_9 AS S_PL_9,  S_PL_10 AS S_PL_10,  S_WG_ID AS S_WG_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;