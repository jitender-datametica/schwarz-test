CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fipo_antwort AS SELECT fipo_antwort_id,
 fipo_bericht_id,
 fipo_pruefpunkt_id,
 fipo_antwort_bwz,
 fipo_antwort_text,
 fipo_antwort_num
FROM kfl_production_dbp_data.fipo_antwort;