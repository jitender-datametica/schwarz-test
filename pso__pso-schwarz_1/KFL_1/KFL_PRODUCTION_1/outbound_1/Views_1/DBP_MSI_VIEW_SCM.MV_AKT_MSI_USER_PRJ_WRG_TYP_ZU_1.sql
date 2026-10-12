-- 20221014 richternic: Ueber Variable statt ueber die AKT_MSI_USER_1 zu joinen.

-- In MSI im Pre-Statment wird die Variable user_id gesetzt

-- 20240529 nwag: workaround to use AKT_MSI_USER_1 as a fallback

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_scm.mv_akt_msi_user_prj_wrg_typ_zu_1(USERID STRING) AS SELECT DISTINCT V01.user_id,
 V01.wrg_typ_id
FROM kfl_production_dbp_msi_view_scm.user_prj_wrg_typ_zu_1 AS V01
 LEFT JOIN kfl_production_dbp_msi_data.akt_msi_user_1 AS V02 ON V02.session_id = ABS(FARM_FINGERPRINT(SESSION_USER()))
WHERE V01.user_id = USERID;