create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TOUR_WE_DET_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	LAGERNUMMER_ID,
	TOUR_ID,
	WGVGRP_ID,
	LIEF_BELEG_ID,
	SEQ_NUMMER,
	ART_ID,
	KJ_LIEF_BELEG,
	GRUPPENZONE_ID,
	AUSSCHLUSS_MANUELL_FG,
	AUSSCHLUSS_REGEL_FG,
	BLOCKARTIKEL_FG,
	LAGERPLATZ_ID,
	ANZAHL_PALETTEN_KALKULIERT
) as
   SELECT
   V02.mandant_id, v02.wup_id, v02.nb_id, v02.lagernummer_id, v02.tour_id, v01.wgvgrp_id, v03.lief_beleg_id, v01.seq_nummer, v01.art_id, v03.kj_lief_beleg, v01.gruppenzone_id, v01.ausschluss_manuell_fg, v01.ausschluss_regel_fg, v01.blockartikel_fg, v01.lagerplatz_id, 1
   FROM dbp_view.v_tour_2 v02
   LEFT JOIN dbp_view.v_tour_det_2 v03
   ON (v02.mandant_id=v03.mandant_id AND v02.tour_id=v03.tour_id )
   LEFT JOIN dbp_view.v_tour_we_det_2 v01
   ON (v01.mandant_id=v02.mandant_id AND v01.tour_id=v02.tour_id AND v01.lief_beleg_id=v03.lief_beleg_id)
   JOIN dbp_view.v_tag_2 t ON v02.dat_tour = t.dat AND t.akt_kj BETWEEN -2 AND 0;