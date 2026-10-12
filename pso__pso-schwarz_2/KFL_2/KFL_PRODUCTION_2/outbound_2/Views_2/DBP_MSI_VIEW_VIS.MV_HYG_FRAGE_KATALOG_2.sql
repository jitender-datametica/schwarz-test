CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hyg_frage_katalog_2 AS SELECT frage_katalog_id,
 frage_katalog_bez,
 frage_katalog_bez_lang,
 gj
FROM kfl_production_dbp_view.v_hyg_frage_katalog_2;