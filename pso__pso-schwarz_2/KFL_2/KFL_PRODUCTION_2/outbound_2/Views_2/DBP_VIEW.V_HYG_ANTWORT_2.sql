CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hyg_antwort_2 AS SELECT frage_katalog_id,
 gj,
 hyg_antwort_id,
 antwort_gruppe_id,
 nicht_relevant_fg,
 antwort_pos_id,
 antwort_punktwert,
 antwort_status_fg
FROM kfl_production_dbp_data.hyg_antwort_2;