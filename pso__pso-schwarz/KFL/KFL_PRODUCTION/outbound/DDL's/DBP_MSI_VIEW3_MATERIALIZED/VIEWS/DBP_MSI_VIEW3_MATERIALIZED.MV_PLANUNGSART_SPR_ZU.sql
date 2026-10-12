CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_planungsart_spr_zu(USERID STRING) AS SELECT V01_DE.mandant_id,
 V01_DE.planungsart_id,
 V02.spr_id,
 COALESCE(V01.planungsart_bez, V01_DE.planungsart_bez) AS planungsart_bez
FROM kfl_production_dbp_view.v_planungsart_spr_zu AS V01_DE
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu(USERID) AS V02 ON TRUE
 LEFT JOIN kfl_production_dbp_view.v_planungsart_spr_zu AS V01 ON V01_DE.mandant_id = V01.mandant_id AND V01_DE.planungsart_id
     = V01.planungsart_id AND V02.spr_id = V01.spr_id
WHERE V01_DE.spr_id = 22;