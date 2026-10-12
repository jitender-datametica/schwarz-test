CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ts_mercareon_mapping_2 AS SELECT mercareon_standort,
 mercareon_entladestelle,
 mandant_id,
 wup_id,
 nb_id,
 lagernummer_ewm_id,
 lagernummer_les_id,
 entladestelle_id,
 artikelsortiment_id
FROM kfl_production_dbp_data.ts_mercareon_mapping_2;