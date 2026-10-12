CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_ncs_log_2 (date_start, service_id, time_start, date_end, time_end
, status_2, service_name) AS SELECT *
FROM kfl_production_dbp_msi_v_view.v_ncs_log_2 AS V01;