CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hyg_frage_1 AS SELECT frage_katalog_id,
 gj,
 hyg_frage_id,
 antwort_gruppe_id
FROM kfl_production_dbp_data.hyg_frage_1;