create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_ARTKZ_ESB_1(
	ESB_ID,
	ESB_BEZ,
	MANDANT_ID,
	SPR_ID
) as
   SELECT
   esb_id, (CASE WHEN esb_bez='system generated' THEN 'kein Esbartikel' ELSE esb_bez END) AS esb_bez, mandant_id, spr_id

   FROM dbp_view.v_artkz_esb_1
   WHERE mandant_id = 1
   and spr_id = 22;