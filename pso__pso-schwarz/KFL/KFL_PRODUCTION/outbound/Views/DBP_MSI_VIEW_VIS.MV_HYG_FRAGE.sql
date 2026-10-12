CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hyg_frage AS SELECT frage_katalog_id,
 hyg_frage_id,
 antwort_gruppe_id,
 gj
FROM kfl_production_dbp_view.v_hyg_frage
UNION ALL
SELECT frage_katalog_id,
 'ZZZZ' AS hyg_frage_id,
 'ZZZZ' AS antwort_gruppe_id,
 gj
FROM kfl_production_dbp_view.v_hyg_frage_katalog;