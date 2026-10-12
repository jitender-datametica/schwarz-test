CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_NCS_LOG
(
date_start
,service_id
,time_start
,date_end
,time_end
,status
,service_name

)
AS
SELECT
v01.date_start
,v01.service_id
,v01.time_start
,v01.date_end
,v01.time_end
,v01.status
,v01.service_name

FROM dbp_msi_v_view.v_ncs_log v01;