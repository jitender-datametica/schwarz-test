CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_wug_2 (wug_id, wg_id, arthiertyp_id, mandant_id, td_update
, td_insert) AS SELECT wug_id,
 wg_id,
 arthiertyp_id,
 mandant_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wug_2;