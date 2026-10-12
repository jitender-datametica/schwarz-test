CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_tour_fakt_1 (mandant_id, nb_id, wup_id, tour_id, dat_tour,
transportart_id, gp_id, lagernummer_id, anzahl_tour) AS SELECT V01.mandant_id,
 V01.nb_id,
 V01.wup_id,
 V01.tour_id,
 V01.dat_tour,
 V01.transportart_id,
 V01.gp_id,
 V02.lagernummer_id,
 V01.tour_id AS anzahl_tour
FROM kfl_production_dbp_view.v_tour_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_tour_det_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id AND
    V01.nb_id = V02.nb_id AND V01.tour_id = V02.tour_id
WHERE V02.loesch_fg = 0
 AND EXTRACT(YEAR FROM V01.dat_tour) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;