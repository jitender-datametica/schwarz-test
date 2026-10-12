CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mdl_feedback_1 AS SELECT feedback_id,
 frage_id,
 antwort_id,
 dat_feedback,
 dat_einkauf,
 zeitspanne_einkauf_id,
 mandant_id,
 gf_id,
 wup_id,
 nb_id,
 de_wup_load_fg
FROM kfl_production_dbp_view.v_mdl_feedback_1 AS V01;