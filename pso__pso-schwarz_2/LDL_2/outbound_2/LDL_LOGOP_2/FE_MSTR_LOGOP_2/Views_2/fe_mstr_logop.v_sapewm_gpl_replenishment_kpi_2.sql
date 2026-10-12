/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_gpl_replenishment_kpi_2
Description		|	SAP EWM Gruppenleiter Dahsboard Replenishment - KPI View
====================================================================================================
*/
/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_gpl_replenishment_kpi_2
Description		|	SAP EWM Gruppenleiter Dahsboard Replenishment - KPI View
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_gpl_replenishment_kpi_2 (client_id
OPTIONS(description='Client id (PK)'), wh_id OPTIONS(description='Warehouse ID (PK)'), wh_task_nr
OPTIONS(description='Warehouse Task (PK)'), conf_by
OPTIONS(description='Confirmed by - Technical name: CONFIRMED_BY - Component Type: /SCWM/DE_CONFIRMEDBY'), conf_dt
OPTIONS(description='Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE'),
conf_tm
OPTIONS(description='Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME'),
conf_ts OPTIONS(description='Confirmation timestamp'), src_hu
OPTIONS(description='Source Handling Unit_2 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'), dest_hu
OPTIONS(description='Destination Handling Unit. Source column name: NLENR'), rsrc OPTIONS(description='Resource'),
rsrc_type OPTIONS(description='Resource type'), wh_area OPTIONS(description='Warehouse area'), movement_type
OPTIONS(description='Movement type'), hu_size
OPTIONS(description='Calculated amount of handling units after successful end of task'), hu_type
OPTIONS(description='Handling Unit_2 Type. Source column name: LETYP'), queue
OPTIONS(description='Queue. Source column name: QUEUE'), area
OPTIONS(description='Warehouse area. Made to the exact specifications from Repl. Functional Concept.'), priority
OPTIONS(description='Replenishment Priority'), stat
OPTIONS(description='Status_2 of Warehouse task (Closed/Waiting/Open)'), start_time
OPTIONS(description='Timestamp of task end or unload from resource'), end_time
OPTIONS(description='Timestamp of task start or load on resource'), prev_start_ts
OPTIONS(description='Start timestamp from previous task group'), prev_end_ts
OPTIONS(description='Start timestamp from previous task group'), exec_time OPTIONS(description='Execution time'),
travel_dur OPTIONS(description='Travel ime'), exec_dur_sec
OPTIONS(description='Execution Time (Seconds) with maximum of 15 min'), travel_dur_sec
OPTIONS(description='Travel Time (Seconds) with maximum of 20 min'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'))
OPTIONS(DESCRIPTION = `SAP EWM FORKLIFT REPORT FORKLIFT PRODUCTIVITY - VIEW WITH ADDITIONAL COLUMNS (BASED ON V_SAPEWM_WHTASK_2 AND MV_REF_QUEUE_2)`)
AS SELECT *
FROM ldl_logop_fe_mstr_logop.v_sapewm_gpl_replenishment_add_2;