create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW3.TBL_MV_ABT_SPR_ZU_2(
	MANDANT_ID,
	ABT_ID,
	ARTHIERTYP_ID,
	SPR_ID,
	ABT_BEZ
) as
   SELECT
   v01.mandant_id, v01.abt_id, v01.arthiertyp_id, v01.spr_id, v01.abt_bez

   FROM dbp_view.v_abt_spr_zu_2 v01

   WHERE v01.arthiertyp_id = 2;
