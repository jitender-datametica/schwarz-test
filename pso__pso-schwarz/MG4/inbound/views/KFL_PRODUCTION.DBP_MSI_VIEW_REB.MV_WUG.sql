create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_WUG(
	MANDANT_ID,
	ARTHIERTYP_ID,
	WUG_ID,
	WG_ID
) as
   SELECT
   1, arthiertyp_id, wug_id, wg_id

   FROM dbp_view.v_wug
   WHERE mandant_id = 1
   AND arthiertyp_id = 2
;