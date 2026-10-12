CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_NCS_LOG_1
(
date_start
,service_id
,time_start
,date_end
,time_end
,status_1
,service_name

)
AS
SELECT
v01.date_start
,v01.service_id
,v01.time_start
,v01.date_end
,v01.time_end
,v01.status_1
,v01.service_name

FROM dbp_msi_v_view.v_ncs_log_1 v01;