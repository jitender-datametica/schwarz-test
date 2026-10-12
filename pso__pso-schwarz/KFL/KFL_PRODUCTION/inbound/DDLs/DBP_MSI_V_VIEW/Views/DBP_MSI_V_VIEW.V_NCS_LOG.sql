CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_NCS_LOG
AS SELECT
date_start,
service_id,
time_from_parts(0,0,time_start/1000) as time_start,
date_end,
time_from_parts(0,0,time_end/1000) as time_end,
status,
service_name


FROM dbp_msi_data.ncs_log

;