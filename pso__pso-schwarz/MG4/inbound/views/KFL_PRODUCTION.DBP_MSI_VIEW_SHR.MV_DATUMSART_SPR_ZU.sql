create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_DATUMSART_SPR_ZU(
	MANDANT_ID,
	DATUMSART_ID,
	DATUMSART_BEZ
) as
   SELECT
   v01.mandant_id, v01.datumsart_id, v01.datumsart_bez

   FROM dbp_view.v_datumsart_spr_zu v01
   WHERE v01.spr_id = 22
;