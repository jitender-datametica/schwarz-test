create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW3.MV_ABT_SPR_ZU_1(
	MANDANT_ID,
	ABT_ID,
	ARTHIERTYP_ID,
	SPR_ID,
	ABT_BEZ
) as
-- 20230717 staeblern Umstellung auf Session Variable 
   SELECT
   v01.mandant_id, v01.abt_id, v01.arthiertyp_id, v01.spr_id, v01.abt_bez

   FROM DBP_MSI_VIEW3.TBL_MV_ABT_SPR_ZU_1 v01

   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_1 v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.arthiertyp_id = 2;
