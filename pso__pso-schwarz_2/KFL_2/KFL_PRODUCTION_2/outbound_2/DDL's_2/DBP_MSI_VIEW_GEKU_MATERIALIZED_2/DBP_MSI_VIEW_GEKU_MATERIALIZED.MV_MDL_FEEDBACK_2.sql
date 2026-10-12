CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_mdl_feedback_2 (feedback_id, frage_id, antwort_id
, dat_feedback, dat_einkauf, zeitspanne_einkauf_id, mandant_id, gf_id, wup_id, nb_id) AS SELECT V01.feedback_id,
 V01.frage_id,
 V01.antwort_id,
 V01.dat_feedback,
 V01.dat_einkauf,
 V01.zeitspanne_einkauf_id,
 V01.mandant_id,
 V01.gf_id,
 V02.aktuell_wup_id AS wup_id,
 V01.nb_id
FROM kfl_production_dbp_view.v_mdl_feedback_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS V02 ON V01.wup_id = V02.wup_id AND V01.mandant_id = V02.mandant_id
WHERE V01.de_wup_load_fg <> 1;