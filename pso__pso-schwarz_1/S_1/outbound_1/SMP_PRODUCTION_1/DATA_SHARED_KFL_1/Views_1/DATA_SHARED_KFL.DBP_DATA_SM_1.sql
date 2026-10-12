CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_sm_1 (mandant_id, sm_id, spr_id, sap_sm_id, sm_bez,
td_update, td_insert) AS SELECT mandant_id,
 sm_id,
 spr_id,
 sap_sm_id,
 sm_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.sm_1;