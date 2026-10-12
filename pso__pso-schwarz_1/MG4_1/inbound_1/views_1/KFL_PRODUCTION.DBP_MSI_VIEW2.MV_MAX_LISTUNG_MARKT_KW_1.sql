create or replace view KFL_PRODUCTION.DBP_MSI_VIEW2.MV_MAX_LISTUNG_MARKT_KW_1(
	MANDANT_ID,
	ART_ID,
	WG_ID,
	WUP_ID,
	NB_ID,
	KREISTYP_GRUPPE_ID,
	KJWO,
	LISTUNG
) as
   SELECT
   v01.mandant_id, v01.art_id, v01.wg_id, v01.wup_id, v01.nb_id, v01.kreistyp_gruppe_id, v01.kjwo, v01.listung_id

   FROM dbp_view.v_art_wup_listung_kjwo_1 v01

   WHERE v01.mandant_id = 1;