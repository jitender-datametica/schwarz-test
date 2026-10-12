CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hyg_frage_katalog_1 AS SELECT frage_katalog_id,
 gj,
 frage_katalog_bez,
 frage_katalog_bez_lang
FROM kfl_production_dbp_data.hyg_frage_katalog_1;