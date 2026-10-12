

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu_1 (USERID STRING) AS SELECT  user_id,
 wrg_typ_id
FROM kfl_production_dbp_msi_view_log.user_prj_wrg_typ_zu_1 AS V01
WHERE user_id = USERID;


