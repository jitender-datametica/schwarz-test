CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hyg_thema AS SELECT frage_katalog_id,
 hyg_thema_id,
 gj,
 hyg_thema_mutter_id,
 hyg_thema_pos_id
FROM kfl_production_dbp_data.hyg_thema;