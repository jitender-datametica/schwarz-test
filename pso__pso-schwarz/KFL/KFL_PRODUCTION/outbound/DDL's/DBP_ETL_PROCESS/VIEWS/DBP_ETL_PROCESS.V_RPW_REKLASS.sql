CREATE OR REPLACE VIEW kfl_production_dbp_etl_process.v_rpw_reklass (mandant_id, wg_id, td_update, td_insert) AS SELECT
 *
FROM kfl_production_dbp_process.rpw_reklass;