/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_forklift_productivity_kpi_1
Description		|	SAP EWM Forklift - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_forklift_productivity_kpi_1 (client_id
OPTIONS(description='Client id (PK)'), wh_id OPTIONS(description='Warehouse ID (PK)'), wh_task_nr
OPTIONS(description='Warehouse Task (PK)'), conf_dt
OPTIONS(description='Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE'),
conf_tm
OPTIONS(description='Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME'),
conf_ts OPTIONS(description='Confirmation timestamp'), src_hu
OPTIONS(description='Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR (PK)'), dest_hu
OPTIONS(description='Destination Handling Unit. Source column name: NLENR'), src_hu_ep
OPTIONS(description='Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'), src_hu_dd
OPTIONS(description='Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'), src_hu_qp
OPTIONS(description='Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'), src_hu_sg
OPTIONS(description='Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'), src_hu_hg
OPTIONS(description='Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'), src_hu_qg
OPTIONS(description='Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'), dest_hu_ep
OPTIONS(description='Destination Handling Unit_1'), dest_hu_dd OPTIONS(description='Destination Handling Unit_1'),
dest_hu_qp OPTIONS(description='Destination Handling Unit_1'), dest_hu_sg OPTIONS(description='Destination Handling Unit_1'),
dest_hu_hg OPTIONS(description='Destination Handling Unit_1'), dest_hu_qg OPTIONS(description='Destination Handling Unit_1'),
wh_area OPTIONS(description='Warehouse area'), movement_type OPTIONS(description='Movement type'), rsrc_type
OPTIONS(description='Resource type'), hu_size
OPTIONS(description='Calculated amount of handling units after successful end of task'), hu_type
OPTIONS(description='Handling Unit_1 Type. Source column name: LETYP'), queue
OPTIONS(description='Queue. Source column name: QUEUE'), start_time
OPTIONS(description='Timestamp of task end or unload from resource'), end_time
OPTIONS(description='Timestamp of task start or load on resource'), prev_start_ts
OPTIONS(description='Start timestamp from previous task group'), prev_end_ts
OPTIONS(description='Start timestamp from previous task group'), exec_time OPTIONS(description='Execution time'),
travel_dur OPTIONS(description='Travel ime'), exec_dur_sec OPTIONS(description='Execution Time with maximum of 15 min'),
travel_dur_sec OPTIONS(description='Travel Time with maximum of 20 min'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'))
OPTIONS(DESCRIPTION = `SAP EWM FORKLIFT REPORT FORKLIFT PRODUCTIVITY - KPI VIEW (BASED ON V_SAPEWM_FORKLIFT_PRODUCTIVITY_ADD_1)`)
AS SELECT client_id,
 wh_id,
 wh_task_nr,
 conf_dt,
 conf_tm,
 conf_ts,
 src_hu,
 dest_hu,
 src_hu_ep,
 src_hu_dd,
 src_hu_qp,
 src_hu_sg,
 src_hu_hg,
 src_hu_qg,
 dest_hu_ep,
 dest_hu_dd,
 dest_hu_qp,
 dest_hu_sg,
 dest_hu_hg,
 dest_hu_qg,
 wh_area,
 movement_type,
 rsrc_type,
 hu_size,
 hu_type,
 queue,
 start_time,
 end_time,
 prev_start_ts,
 prev_end_ts,
 exec_time,
 travel_dur,
 exec_dur_sec,
 travel_dur_sec,
 dwh_created,
 dwh_updated
FROM ldl_logop_fe_mstr_logop.v_sapewm_forklift_productivity_add_1;