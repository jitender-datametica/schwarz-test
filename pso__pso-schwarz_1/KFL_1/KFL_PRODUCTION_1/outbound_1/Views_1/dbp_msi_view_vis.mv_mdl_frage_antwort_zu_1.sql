CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mdl_frage_antwort_zu_1 AS SELECT frage_id,
 antwort_id,
 nok_fg
FROM kfl_production_dbp_view.v_mdl_frage_antwort_zu_1 AS V01;