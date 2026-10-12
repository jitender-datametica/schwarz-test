CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_mdl_feedback_1 (feedback_id, frage_id, antwort_id
, dat_feedback, dat_einkauf, zeitspanne_einkauf_id, mandant_id, gf_id, wup_id, nb_id) AS SELECT v01.feedback_id,
 v01.frage_id,
 v01.antwort_id,
 v01.dat_feedback,
 v01.dat_einkauf,
 v01.zeitspanne_einkauf_id,
 v01.mandant_id,
 v01.gf_id,
 v02.aktuell_wup_id AS wup_id,
 v01.nb_id
FROM kfl_production_dbp_view.v_mdl_feedback_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS v02 ON v01.wup_id = v02.wup_id AND v01.mandant_id = v02.mandant_id
WHERE v01.de_wup_load_fg <> 1;