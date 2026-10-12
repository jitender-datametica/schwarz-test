create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_TEMPERATUR_SPR_ZU_1(
	MANDANT_ID,
	SPR_ID,
	TEMPERATUR_ID,
	TEMPERATUR_BEZ
) as
   SELECT
   mandant_id, spr_id, temperatur_id, temperatur_bez

   FROM dbp_view.v_temperatur_spr_zu_1
   WHERE mandant_id = 1
   AND spr_id = 22;