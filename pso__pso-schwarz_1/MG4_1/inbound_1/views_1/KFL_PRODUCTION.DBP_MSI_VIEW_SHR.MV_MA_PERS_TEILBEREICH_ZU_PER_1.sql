create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_MA_PERS_TEILBEREICH_ZU_PER_1(
	MANDANT_ID,
	PERS_BEREICH_ID,
	PERS_TEILBEREICH_ID,
	MITARBEITER_ID,
	KJMO,
	BUCHUNGSKREIS_ID,
	PERSTEILBEREICH_BEZ
) as
   SELECT
   v01.mandant_id, v01.pers_bereich_id, v01.pers_teilbereich_id, v01.mitarbeiter_id, v01.kjmo, v01.buchungskreis_id, v02.persteilbereich_bez



   FROM dbp_view.v_ma_pers_teilbereich_zu_per_1 v01
   JOIN dbp_view.v_pers_teilbereich_spr_zu_1          v02
   ON   v01.mandant_id               = v02.mandant_id
   AND v01.pers_bereich_id      = v02.pers_bereich_id
   AND v01.pers_teilbereich_id = v02.pers_teilbereich_id
   AND v01.buchungskreis_id    = v02.buchungskreis_id
   AND v02.spr_id = 22;