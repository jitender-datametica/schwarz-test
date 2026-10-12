-- 20230717 staeblern Umstellung auf Sessionvairable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu(USERID STRING) AS
-- dbp_msi_v_view.v_user_wrg_typ_zu
 SELECT user_id,
 wrg_typ_id
FROM kfl_production_dbp_msi_view_log.user_prj_wrg_typ_zu AS V01
WHERE user_id = USERID;