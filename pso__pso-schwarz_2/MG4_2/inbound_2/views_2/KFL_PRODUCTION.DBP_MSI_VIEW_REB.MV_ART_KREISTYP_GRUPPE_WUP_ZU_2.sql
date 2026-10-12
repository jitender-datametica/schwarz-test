create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_ART_KREISTYP_GRUPPE_WUP_ZU_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	KREISTYP_GRUPPE_ID
) as
   SELECT
   mandant_id, wup_id, nb_id, art_id, kreistyp_gruppe_id

   FROM dbp_view.v_art_kreistyp_gruppe_wup_zu_2
   WHERE nb_id = 0;