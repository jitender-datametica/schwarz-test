create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW3.MV_USER_SPR_ZU_1(
	USER_ID,
	SPR_ID
) as
SELECT DISTINCT  
v01.user_id, v01.spr_id
FROM  dbp_msi_v_view.v_user_spr_zu_1 v01
WHERE  v01.user_id = getvariable('USERID');
