CREATE OR REPLACE VIEW kfl_production_dbp_etl_process.lead_wup_region (region_id, wup_id, mandant_id, land_id, td_update
, td_insert) AS SELECT *
FROM kfl_production_dbp_process.lead_wup_region;