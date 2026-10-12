CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_kmr_l_pruefung_standort (standort_id, amx_system_id,
standort_typ_id, standort_bez) AS SELECT standort_id,
 amx_system_id,
 standort_typ_id,
 standort_bez
FROM kfl_production_dbp_view.v_kmr_l_pruefung_standort AS V01;