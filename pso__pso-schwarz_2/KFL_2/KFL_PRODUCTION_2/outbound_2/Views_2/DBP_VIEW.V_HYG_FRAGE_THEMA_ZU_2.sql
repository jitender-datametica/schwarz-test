CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hyg_frage_thema_zu_2 AS SELECT frage_katalog_id,
 hyg_frage_id,
 hyg_thema_id,
 gj,
 hyg_frage_pos_id
FROM kfl_production_dbp_data.hyg_frage_thema_zu_2;