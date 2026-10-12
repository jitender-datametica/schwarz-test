CREATE OR REPLACE VIEW kfl_production_dbp_etl_process.snfl_track_tables (object_name, td_update, td_insert) AS SELECT *
FROM kfl_production_dbp_process.snfl_track_tables;