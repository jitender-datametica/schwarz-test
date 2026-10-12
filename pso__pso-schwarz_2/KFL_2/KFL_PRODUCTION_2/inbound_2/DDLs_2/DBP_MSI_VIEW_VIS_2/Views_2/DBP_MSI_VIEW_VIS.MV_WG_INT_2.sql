create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_WG_INT_2(
	ARTHIERTYP_ID,
	WG_ID,
	OWG_ID,
	SORT_ID
) as
   -- LOOKUP/ZUORDNUNG : Warengruppe International
   -- 2018.09 : WG Refresh

   SELECT DISTINCT
   wg.arthiertyp_id, wg.wg_id, wg.owg_id, wg.owg_id * 10000 + wg.wg_id::INTEGER AS sort_id
   FROM dbp_view.v_wg_per_2 wg
   WHERE wg.arthiertyp_id = 2 AND wg.dat_bis = '9999-12-31'

   GROUP BY arthiertyp_id, wg_id, owg_id, sort_id;
