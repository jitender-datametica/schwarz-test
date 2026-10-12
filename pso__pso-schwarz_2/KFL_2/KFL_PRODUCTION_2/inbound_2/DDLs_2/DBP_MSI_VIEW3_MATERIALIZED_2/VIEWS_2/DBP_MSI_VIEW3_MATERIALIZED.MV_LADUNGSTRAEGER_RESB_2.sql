create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LADUNGSTRAEGER_RESB_2(
	MANDANT_ID,
	RESERVIERUNG_ID,
	RESERVIERUNG_POS_ID,
	DAT_VON,
	DAT_BIS,
	DAT,
	ERLEDIGT_FG,
	ART_ID,
	WUP_ID,
	NB_ID,
	DAT_AUSSTELLUNG,
	ANZ_LADUNGSTRAEGER,
	LAGER_BEWART_ID,
	DAT_AENDERUNG,
	BEWEGUNG_ERLAUBT_FG,
	SPEDITEUR_ID,
	VK_BRUTTO
) as

   SELECT
   v01.mandant_id, v01.reservierung_id, v01.reservierung_pos_id, v01.dat_von, v01.dat_bis, v03.dat, v01.erledigt_fg, v01.art_id, v01.wup_id, v01.nb_id, v01.dat_ausstellung, v01.anz_ladungstraeger, v01.lager_bewart_id, v01.dat_aenderung, v01.bewegung_erlaubt_fg, v01.spediteur_id, v99.vk_brutto

   FROM dbp_view.v_ladungstraeger_resb_2 v01
   LEFT OUTER JOIN
   (
   SELECT
   v02.mandant_id, v02.art_id, MAX(V02.vk_brutto) AS vk_brutto

   FROM dbp_view.v_art_pm_vw_zu_per_2 v02

   WHERE  v02.dat_bis = '9999-12-31'
   AND  (v02.art_id / 100  IN (9840018,9840133,9840042,9840059,9802554)  )
   AND (
   (v02.mandant_id  = 1 AND preistyp_id = 0 AND pm_id IN (1,10) AND v02.vw_id IN (1,2,3)) OR
   (v02.mandant_id <> 1 AND preistyp_id = 0 AND pm_id IN (1,10) AND v02.vw_id IN (10,90))
   )
   GROUP BY 1,2
   ) v99
   ON     v01.mandant_id = v99.mandant_id
   AND  v01.art_id          = v99.art_id

   JOIN dbp_view.v_tag_2 v03
   ON   v03.dat BETWEEN v01.dat_von AND  v01.dat_bis
   AND v03.akt_kj > -3
   AND v03.dat <= CURRENT_DATE
   WHERE extract(year from v03.dat) >= year(current_timestamp) - 2;