create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_KREISTYP_GRUPPE_SPR_ZU_1(
	MANDANT_ID,
	KREISTYP_GRUPPE_ID,
	SPR_ID,
	KREISTYP_GRUPPE_BEZ
) as
   SELECT
   mandant_id, kreistyp_gruppe_id, spr_id, kreistyp_gruppe_bez
   FROM dbp_view.v_kreistyp_gruppe_spr_zu_1

   WHERE spr_id = 22;