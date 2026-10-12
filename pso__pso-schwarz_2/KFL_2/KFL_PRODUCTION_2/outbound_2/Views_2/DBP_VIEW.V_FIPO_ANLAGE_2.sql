CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fipo_anlage_2 AS SELECT fipo_anlage_id,
 fipo_antwort_id,
 fipo_anlage_content,
 mime_type,
 dat_bis
FROM kfl_production_dbp_data.fipo_anlage_2;