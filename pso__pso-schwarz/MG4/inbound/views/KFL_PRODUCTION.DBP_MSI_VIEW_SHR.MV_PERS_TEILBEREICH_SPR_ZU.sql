create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_PERS_TEILBEREICH_SPR_ZU(
	MANDANT_ID,
	PERS_BEREICH_ID,
	PERS_TEILBEREICH_ID,
	BUCHUNGSKREIS_ID,
	PERSTEILBEREICH_BEZ
) as
   SELECT
   v01.mandant_id, v01.pers_bereich_id, v01.pers_teilbereich_id, v01.buchungskreis_id, v02.persteilbereich_bez


   FROM dbp_view.v_l_pers_teilbereich      v01
   JOIN dbp_view.v_pers_teilbereich_spr_zu       v02
   ON   v01.mandant_id               = v02.mandant_id
   AND v01.pers_bereich_id      = v02.pers_bereich_id
   AND v01.pers_teilbereich_id = v02.pers_teilbereich_id
   AND v01.buchungskreis_id    = v02.buchungskreis_id
   AND v02.spr_id = 22;