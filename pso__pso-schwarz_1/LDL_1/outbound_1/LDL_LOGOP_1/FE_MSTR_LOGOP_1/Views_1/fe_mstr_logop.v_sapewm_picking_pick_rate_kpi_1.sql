/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_picking_pick_rate_kpi_1
Description		|	SAP EWM Pick Rate - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_picking_pick_rate_kpi_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number'), wh_nr
OPTIONS(description='Warehouse Number/Warehouse Complex. Source column name: LGNUM'), wh_task_nr
OPTIONS(description='Warehouse Task. Source column name: TANUM'), act_type
OPTIONS(description='Activity. Source column name: ACT_TYPE'), wh_task_item
OPTIONS(description='Warehouse Task Item. Source column name: TAPOS'), wh_task_stat
OPTIONS(description='Warehouse Task Status. Source column name: TOSTAT'), conf_by
OPTIONS(description='Confirmed by. Source column name: CONFIRMED_BY'), conf_dt
OPTIONS(description='Confirmation Date. Source column name: CONFIRMED_DATE'), conf_tm
OPTIONS(description='Confirmation Time. Source column name: CONFIRMED_TIME'), exc_cd
OPTIONS(description='Exception Code. Source column name: EXCCODE'), start_dt
OPTIONS(description='Start Date. Source column name: STARTED_DATE'), start_tm
OPTIONS(description='Start Time. Source column name: STARTED_TIME'), conf_tm_hh
OPTIONS(description='Confirmation time rounded down'), act_dest_qty_auom
OPTIONS(description='Actual Destination Quantity in Alternative Unit. Source column name: NISTA'), hu_type
OPTIONS(description='Handling Unit_1 Type. Source column name: LETYP'), dest_strg_bin
OPTIONS(description='Destination Storage Bin. Source column name: NLPLA'), queue
OPTIONS(description='Queue. Source column name: QUEUE'), perf_area OPTIONS(description='Performance area'), act_area
OPTIONS(description='Activity Area. Source column name: AAREA'), wh_ord_nr
OPTIONS(description='Warehouse Order Number. Source column name: WHO'), act_qty_auom_case
OPTIONS(description='Actual Quantity in Alternative Unit_1 of Measure Case. Source column name: ZZ_QTY_CASE'), auom_case
OPTIONS(description='Alternative Unit_1 of Measure Case. Source column name: ZZ_AUOM_CASE'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), first_queue
OPTIONS(description='First queue within a warehouse order'), rsrc
OPTIONS(description='Resource (Means of Transportation or User)'), start_dt_who
OPTIONS(description='Start Date. Source column name: STARTED_DATE'), start_tm_who
OPTIONS(description='Start Time. Source column name: STARTED_TIME'), amt_pallet_ep
OPTIONS(description='Amount of pallets in EP equivalent based on HU type'), amt_pallet
OPTIONS(description='Amount of pallets in EP equivalent based on HU type'), amt_case
OPTIONS(description='Amount of cases based on actual quantity in alternative unit_1 case'), amt_pick
OPTIONS(description='Amount of picks based on actual destination quantity auom'), skipped
OPTIONS(description='Skiped possition - warehouse task with the exeption codes “ZPPD, ZFPD, ZFPM”'), grp_who_first
OPTIONS(description='Sorting number for group of WH order ascending'), grp_who_last
OPTIONS(description='Sorting number for group of WH order descending'), grp_who_emp_first
OPTIONS(description='Sorting number for group of WH order and employee_1 ascending'), grp_who_emp_last
OPTIONS(description='Sorting number for group of WH order and employee_1 descending'), pick_start_dt
OPTIONS(description='Start date of pick'), pick_start_tm OPTIONS(description='Start time of pick'), pick_start_tm_hh
OPTIONS(description='Starting hour of pick rounded down'), pick_end_dt OPTIONS(description='End date of pick'),
pick_end_tm OPTIONS(description='End time of pick'), pick_end_tm_hh
OPTIONS(description='Ending hour of pick rounded up'), work_tm_sec OPTIONS(description='Working time in seconds'),
sum_break_sec OPTIONS(description='Break time in seconds'))
OPTIONS(DESCRIPTION = `SAP EWM PICKING - VIEW WITH FINAL KPIS FOR FE`) AS SELECT client_id,
 wh_id,
 wh_nr,
 wh_task_nr,
 act_type,
 wh_task_item,
 wh_task_stat,
 conf_by,
 conf_dt,
 conf_tm,
 exc_cd,
 start_dt,
 start_tm,
 conf_tm_hh,
 act_dest_qty_auom,
 hu_type,
 dest_strg_bin,
 queue,
 perf_area,
 act_area,
 wh_ord_nr,
 act_qty_auom_case,
 auom_case,
 dwh_created,
 dwh_updated,
 first_queue,
 rsrc,
 start_dt_who,
 start_tm_who,
 amt_pallet_ep,
 amt_pallet,
 amt_case,
 amt_pick,
 skipped,
 grp_who_first,
 grp_who_last,
 grp_who_emp_first,
 grp_who_emp_last,
 pick_start_dt,
 pick_start_tm,
 pick_start_tm_hh,
 pick_end_dt,
 pick_end_tm,
 pick_end_tm_hh,
 work_tm_sec,
 sum_break_sec
FROM ldl_logop_fe_mstr_logop.v_sapewm_picking_pick_rate_add_1;