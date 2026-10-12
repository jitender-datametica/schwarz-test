create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LIEFERVERZOGERUNGEN_REPORT_2(
	EMPFAENGER_WUP_ID,
	ANZ_POS_AKTIV,
	MANDANT_ID,
	NB_ID,
	GP_ID,
	DAT_BEST_BELEG,
	BESTELLART_ID,
	BEST_BELEG_ID,
	TOUR_ID
) as
   SELECT DISTINCT
  v01.empfaenger_wup_id, v01.anz_pos_aktiv, v01.mandant_id, CASE WHEN v01.empfaenger_wup_id IS NOT NULL THEN CAST(-111 AS SMALLINT)
   END AS nb_id, v01.gp_id, v01.dat_best_beleg, v01.bestellart_id, v01.best_beleg_id, v04.tour_id

   FROM dbp_view.v_besch_best_2 v01
   INNER JOIN dbp_view.v_besch_best_det_2 v02
   ON v01.best_beleg_id = v02.best_beleg_id
   AND v01.dat_best_beleg = v02.dat_best_beleg
   AND v01.mandant_id = v02.mandant_id
   LEFT JOIN dbp_view.v_besch_bestaetigung_2 v03
   ON v02.best_beleg_id = v03.best_beleg_id
   AND v02.best_beleg_pos_id = v03.best_beleg_pos_id
   AND v02.mandant_id = v03.mandant_id
   LEFT JOIN dbp_view.v_tour_det_2 v04
   ON v03.mandant_id = v04.mandant_id
   AND v03.lief_beleg_id = v04.lief_beleg_id
   AND v03.kj_lief_beleg = v04.kj_lief_beleg
   WHERE v01.einkaufsorganisation_id <> 5000 AND v02.loesch_fg = 0 AND v01.loesch_fg = 0;