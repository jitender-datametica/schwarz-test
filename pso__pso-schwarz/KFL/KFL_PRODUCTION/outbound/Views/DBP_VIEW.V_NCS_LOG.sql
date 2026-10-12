CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ncs_log AS SELECT date_start,
 service_id,
 time_start,
 date_end,
 time_end,
 status,
 service_name
FROM kfl_production_dbp_msi_data.ncs_log;