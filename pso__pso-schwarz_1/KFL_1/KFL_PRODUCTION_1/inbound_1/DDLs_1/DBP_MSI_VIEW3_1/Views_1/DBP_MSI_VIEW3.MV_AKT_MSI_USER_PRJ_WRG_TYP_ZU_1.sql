create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW3.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_1(
	USER_ID,
	WRG_TYP_ID
) as 
-- 20220804; richternic, AP0132142, SPEC0154921, Einfuegen der Auswahl der Waehrung 
-- 20230717: steablern Umstellung auf Variable 
SELECT
   DISTINCT v01.user_id,
   v01.wrg_typ_id
FROM
   dbp_msi_view3.USER_PRJ_WRG_TYP_ZU_1 v01 -- dbp_msi_v_view.v_user_wrg_typ_zu_1 
WHERE
   v01.user_id = getvariable('USERID');
