create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_LOHNART_SPR_ZU_2(
	MANDANT_ID,
	LOHNART_ID,
	SPR_ID,
	LOHNART_BEZ
) as
   SELECT
   v01.mandant_id, v01.lohnart_id, v01.spr_id, v01.lohnart_bez

   FROM dbp_view.v_lohnart_spr_zu_2 v01
   JOIN dbp_view.v_mandant_spr_zu_2 v04
   ON v01.mandant_id = v04.mandant_id AND v01.spr_id = v04.spr_id;