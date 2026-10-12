CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_ts_mercareon_mapping_1 (mercareon_standort,
mercareon_entladestelle, mandant_id, wup_id, nb_id, lagernummer_ewm_id, lagernummer_les_id, entladestelle_id,
artikelsortiment_id) AS SELECT mercareon_standort,
 mercareon_entladestelle,
 mandant_id,
 wup_id,
 '-111' AS nb_id,
 lagernummer_ewm_id,
 lagernummer_les_id,
 entladestelle_id,
 artikelsortiment_id
FROM kfl_production_dbp_view.v_ts_mercareon_mapping_1;