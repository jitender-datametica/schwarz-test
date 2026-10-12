create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_ARTKZ_VERPART(
	VERPART_ID,
	VERPART_BEZ,
	MANDANT_ID,
	SPR_ID
) as
   SELECT
   verpart_id, verpart_bez, mandant_id, spr_id

   FROM dbp_view.v_artkz_verpart
   WHERE mandant_id = 1;