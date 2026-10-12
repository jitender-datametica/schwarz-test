create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_WUG_1(
	MANDANT_ID,
	ARTHIERTYP_ID,
	WUG_ID,
	WG_ID
) as
   SELECT 1, arthiertyp_id, wug_id, wg_id
   FROM dbp_view.v_wug_1
   WHERE arthiertyp_id=2;