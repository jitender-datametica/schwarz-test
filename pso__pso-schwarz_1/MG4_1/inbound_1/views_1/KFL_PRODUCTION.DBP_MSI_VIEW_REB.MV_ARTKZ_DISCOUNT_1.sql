create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_ARTKZ_DISCOUNT_1(
	DISCOUNT_ID,
	DISCOUNT_BEZ,
	MANDANT_ID,
	SPR_ID
) as
   SELECT
   discount_id, discount_bez, mandant_id, spr_id

   FROM dbp_view.v_artkz_discount_1
   WHERE mandant_id = 1
   AND spr_id = 22;