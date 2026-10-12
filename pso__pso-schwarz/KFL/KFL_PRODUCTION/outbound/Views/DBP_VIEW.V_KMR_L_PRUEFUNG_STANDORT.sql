CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kmr_l_pruefung_standort AS SELECT amx_system_id,
 standort_id,
 standort_bez,
 standort_typ_id
FROM kfl_production_dbp_data.kmr_l_pruefung_standort;