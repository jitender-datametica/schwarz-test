CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_tour_we_det_2 (mandant_id, wup_id, nb_id, lagernummer_id, tour_id,
wgvgrp_id, lief_beleg_id, seq_nummer, art_id, kj_lief_beleg, gruppenzone_id, ausschluss_manuell_fg, ausschluss_regel_fg
, blockartikel_fg, lagerplatz_id, anzahl_paletten_kalkuliert) AS SELECT V02.mandant_id,
 V02.wup_id,
 V02.nb_id,
 V02.lagernummer_id,
 V02.tour_id,
 V01.wgvgrp_id,
 V03.lief_beleg_id,
 V01.seq_nummer,
 V01.art_id,
 V03.kj_lief_beleg,
 V01.gruppenzone_id,
 V01.ausschluss_manuell_fg,
 V01.ausschluss_regel_fg,
 V01.blockartikel_fg,
 V01.lagerplatz_id,
 1 AS anzahl_paletten_kalkuliert
FROM kfl_production_dbp_view.v_tour_2 AS V02
 LEFT JOIN kfl_production_dbp_view.v_tour_det_2 AS V03 ON V02.mandant_id = V03.mandant_id AND V02.tour_id = V03.tour_id
 LEFT JOIN kfl_production_dbp_view.v_tour_we_det_2 AS V01 ON V02.mandant_id = V01.mandant_id AND V02.tour_id = V01.tour_id
     AND V03.lief_beleg_id = V01.lief_beleg_id
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS T ON V02.dat_tour = T.dat AND T.akt_kj BETWEEN - 2 AND 0;