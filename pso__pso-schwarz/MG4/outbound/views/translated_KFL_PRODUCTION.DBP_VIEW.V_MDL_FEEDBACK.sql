CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mdl_feedback (feedback_id, frage_id, antwort_id, dat_feedback,
dat_einkauf, zeitspanne_einkauf_id, mandant_id, gf_id, wup_id, nb_id, de_wup_load_fg, td_update, td_insert) AS SELECT
 feedback_id,
 frage_id,
 antwort_id,
 dat_feedback,
 dat_einkauf,
 zeitspanne_einkauf_id,
 mandant_id,
 gf_id,
 wup_id,
 nb_id,
 de_wup_load_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.mdl_feedback;