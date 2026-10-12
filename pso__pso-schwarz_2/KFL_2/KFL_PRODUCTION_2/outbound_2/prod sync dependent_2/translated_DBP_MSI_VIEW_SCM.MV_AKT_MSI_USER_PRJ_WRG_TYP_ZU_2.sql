
CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_scm.mv_akt_msi_user_prj_wrg_typ_zu_2 (USERID STRING) AS SELECT DISTINCT V01.user_id
 ,
 V01.wrg_typ_id
FROM kfl_production_dbp_msi_view_scm.user_prj_wrg_typ_zu_2 AS V01
 LEFT JOIN kfl_production_dbp_msi_data.akt_msi_user_2 AS V02 ON V02.session_id = ABS(FARM_FINGERPRINT(SESSION_USER()))
WHERE V01.user_id = USERID;


