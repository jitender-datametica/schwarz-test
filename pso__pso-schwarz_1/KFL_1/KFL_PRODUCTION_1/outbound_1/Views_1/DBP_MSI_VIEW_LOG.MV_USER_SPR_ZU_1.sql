-- 2023 staeblern Umstellung auf Session Variable
 CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_user_spr_zu_1(USERID STRING)
AS SELECT DISTINCT user_id,
 spr_id
FROM kfl_production_dbp_msi_v_view.v_user_spr_zu_1 AS V01
WHERE user_id = USERID;