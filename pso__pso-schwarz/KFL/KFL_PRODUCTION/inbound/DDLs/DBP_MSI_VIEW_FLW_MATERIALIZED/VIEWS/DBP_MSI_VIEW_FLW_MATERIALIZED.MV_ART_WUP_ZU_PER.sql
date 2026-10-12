create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_ART_WUP_ZU_PER(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	DAT,
	ART_ID,
	BEZUGSWEG_ID,
	LISTUNG_ID,
	PLZ_LISTUNG_ID,
	VK_BRUTTO,
	KDIS,
	PLZ_KDIS,
	WRG_ID
) as
   SELECT

   v01.mandant_id, v01.wup_id, v01.nb_id, t1.dat, v01.art_id, v01.bezugsweg_id, v01.listung_id, v03.listung_id AS plz_listung_id, v01.vk_brutto, v01.kdis, v03.kdis AS plz_kdis, v01.wrg_id

   FROM dbp_view.v_art_wup_zu_per   v01

   JOIN dbp_view.v_tag t1
   ON t1.dat BETWEEN v01.dat_von AND v01.dat_bis

   --PLZ ermitteln (aktuellste pro Artikel und Markt)
   JOIN
   dbp_view.v_art_wup_status_per v02
   ON v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id
   AND v01.wup_id = v02.wup_id
   AND v02.dat_bis = '9999-12-31'

   --Listung und KDIS zum Zeitpunkt dat - plz ermitteln
   JOIN
   dbp_view.v_art_wup_zu_per   v03
   ON v01.art_id = v03.art_id
   AND v01.mandant_id = v03.mandant_id
   AND v01.wup_id = v03.wup_id
   AND ( t1.dat - v02.planlieferzeit ) BETWEEN v03.dat_von AND v03.dat_bis;