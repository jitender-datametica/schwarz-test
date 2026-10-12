CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_besch_best_det_1 (mandant_id, best_beleg_id, best_beleg_pos_id,
art_id, wup_id, nb_id, lagerort_id, loesch_fg, endlief_fg, dat_aenderung, kunde_id, dat_best_beleg, wrg_id, betrag_best
, anforderer_name) AS SELECT mandant_id,
 best_beleg_id,
 best_beleg_pos_id,
 art_id,
 wup_id,
 nb_id,
 lagerort_id,
 loesch_fg,
 endlief_fg,
 dat_aenderung,
 kunde_id,
 dat_best_beleg,
 wrg_id,
 betrag_best,
 anforderer_name
FROM kfl_production_dbp_view.v_besch_best_det_1 AS V01;