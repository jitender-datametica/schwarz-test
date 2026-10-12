create or replace view KFL_PRODUCTION.DBP_MSI_VIEW3_MATERIALIZED.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU(
	USER_ID,
	WRG_TYP_ID
) as 
-- 20220804; richternic, AP0132142, SPEC0154921, Einfuegen der Auswahl der Waehrung 
-- 20230717: steablern Umstellung auf Variable 
SELECT
   DISTINCT v01.user_id,
   v01.wrg_typ_id
FROM
   KFL_PRODUCTION.DBP_MSI_VIEW3_MATERIALIZED.USER_PRJ_WRG_TYP_ZU v01 -- dbp_msi_v_view.v_user_wrg_typ_zu 
WHERE
   v01.user_id = getvariable('USERID');