CREATE OR REPLACE VIEW kfl_production_dbp_etl_process.snfl_track_tables_la (databasename, tablename, collecttimestamp,
td_update, td_insert) AS SELECT *
FROM kfl_production_dbp_process.snfl_track_tables_la;