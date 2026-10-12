create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_BEWART_SPR_ZU_1(
	SPR_ID,
	BEWART_ID,
	BEWART_BEZ,
	MANDANT_ID
) as
   SELECT
   spr_id, bewart_id, bewart_bez, mandant_id

   FROM dbp_view.v_bewart_spr_zu_1
   WHERE spr_id = 22
   AND mandant_id = 1
;