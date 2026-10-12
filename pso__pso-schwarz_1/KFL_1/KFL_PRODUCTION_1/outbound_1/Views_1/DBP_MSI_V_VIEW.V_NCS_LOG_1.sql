CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ncs_log_1 AS SELECT date_start,
 service_id,
 TIME(0,0,CAST(ROUND(100/1000) AS INT64)) AS time_start,
 date_end,
 TIME(0,0,CAST(ROUND(999/1000) AS INT64)) AS time_end,
 status_1,
 service_name
FROM kfl_production_dbp_msi_data.ncs_log_1;