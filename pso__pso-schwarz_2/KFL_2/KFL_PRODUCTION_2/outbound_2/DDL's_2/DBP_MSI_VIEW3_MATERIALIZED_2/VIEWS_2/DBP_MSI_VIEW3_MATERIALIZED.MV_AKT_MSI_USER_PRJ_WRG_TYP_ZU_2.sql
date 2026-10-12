-- 20220804; richternic, AP0132142, SPEC0154921, Einfuegen der Auswahl der Waehrung
-- 20230717: steablern Umstellung auf Variable
-- dbp_msi_v_view.v_user_wrg_typ_zu_2

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_akt_msi_user_prj_wrg_typ_zu_2(USERID STRING) 
AS SELECT DISTINCT user_id,
 wrg_typ_id
FROM kfl_production_dbp_msi_view3_materialized.user_prj_wrg_typ_zu_2 AS V01
WHERE user_id = USERID;