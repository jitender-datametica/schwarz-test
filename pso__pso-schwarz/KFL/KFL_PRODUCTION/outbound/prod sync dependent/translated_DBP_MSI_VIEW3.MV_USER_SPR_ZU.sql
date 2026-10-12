CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_user_spr_zu (USERID STRING) AS SELECT DISTINCT user_id,
 spr_id
FROM kfl_production_dbp_msi_v_view.v_user_spr_zu AS V01
WHERE user_id = USERID;


