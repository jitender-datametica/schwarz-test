CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hyg_antwort_gruppe AS SELECT frage_katalog_id,
 antwort_gruppe_id,
 gj,
 antwort_gruppe_typ_id,
 max_wert,
 min_wert,
 keine_antwort_fg
FROM kfl_production_dbp_data.hyg_antwort_gruppe;