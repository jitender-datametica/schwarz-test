create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_ARTKZ_POSTEN(
	POSTEN_ID,
	POSTEN_BEZ,
	MANDANT_ID,
	SPR_ID
) as
   SELECT
   posten_id, posten_bez, mandant_id, spr_id
   FROM dbp_view.v_artkz_posten
   WHERE posten_id IN ('PN','')
   AND mandant_id = 1
   AND spr_id =22;