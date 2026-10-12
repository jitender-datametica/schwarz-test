/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_picking_pick_rate_kpi
Description		|	SAP EWM Pick Rate - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_picking_pick_rate_kpi(
	client_id COMMENT 'Client id - calculated based on the country code',
	wh_id COMMENT 'Warehouse ID. Subset of Warehouse Number',
	wh_nr COMMENT 'Warehouse Number/Warehouse Complex. Source column name: LGNUM',
	wh_task_nr COMMENT 'Warehouse Task. Source column name: TANUM',
	act_type COMMENT 'Activity. Source column name: ACT_TYPE',
	wh_task_item COMMENT 'Warehouse Task Item. Source column name: TAPOS',
	wh_task_stat COMMENT 'Warehouse Task Status. Source column name: TOSTAT',
	conf_by COMMENT 'Confirmed by. Source column name: CONFIRMED_BY',
	conf_dt COMMENT 'Confirmation Date. Source column name: CONFIRMED_DATE',
	conf_tm COMMENT 'Confirmation Time. Source column name: CONFIRMED_TIME',
	exc_cd COMMENT 'Exception Code. Source column name: EXCCODE',
	start_dt COMMENT 'Start Date. Source column name: STARTED_DATE',
	start_tm COMMENT 'Start Time. Source column name: STARTED_TIME',
	conf_tm_hh COMMENT 'Confirmation time rounded down',
	act_dest_qty_auom COMMENT 'Actual Destination Quantity in Alternative Unit. Source column name: NISTA',
	hu_type COMMENT 'Handling Unit Type. Source column name: LETYP',
	dest_strg_bin COMMENT 'Destination Storage Bin. Source column name: NLPLA',
	QUEUE COMMENT 'Queue. Source column name: QUEUE',
	perf_area COMMENT 'Performance area',
	act_area COMMENT 'Activity Area. Source column name: AAREA',
	wh_ord_nr COMMENT 'Warehouse Order Number. Source column name: WHO',
	act_qty_auom_case COMMENT 'Actual Quantity in Alternative Unit of Measure Case. Source column name: ZZ_QTY_CASE',
	auom_case COMMENT 'Alternative Unit of Measure Case. Source column name: ZZ_AUOM_CASE',
	dwh_created COMMENT 'Record created at',
	dwh_updated COMMENT 'Record updated at',
	first_queue COMMENT 'First queue within a warehouse order',
	rsrc COMMENT 'Resource (Means of Transportation or User)',
	start_dt_who COMMENT 'Start Date. Source column name: STARTED_DATE',
	start_tm_who COMMENT 'Start Time. Source column name: STARTED_TIME',
	amt_pallet_ep COMMENT 'Amount of pallets in EP equivalent based on HU type',
	amt_pallet COMMENT 'Amount of pallets in EP equivalent based on HU type',
	amt_case COMMENT 'Amount of cases based on actual quantity in alternative unit case',
	amt_pick COMMENT 'Amount of picks based on actual destination quantity auom',
	skipped COMMENT 'Skiped possition - warehouse task with the exeption codes “ZPPD, ZFPD, ZFPM”',
	grp_who_first COMMENT 'Sorting number for group of WH order ascending',
	grp_who_last COMMENT 'Sorting number for group of WH order descending',
	grp_who_emp_first COMMENT 'Sorting number for group of WH order and employee ascending',
	grp_who_emp_last COMMENT 'Sorting number for group of WH order and employee descending',
	pick_start_dt COMMENT 'Start date of pick',
	pick_start_tm COMMENT 'Start time of pick',
	pick_start_tm_hh COMMENT 'Starting hour of pick rounded down',
	pick_end_dt COMMENT 'End date of pick',
	pick_end_tm COMMENT 'End time of pick',
	pick_end_tm_hh COMMENT 'Ending hour of pick rounded up',
	work_tm_sec COMMENT 'Working time in seconds',
	sum_break_sec COMMENT 'Break time in seconds'
) COMMENT='SAP EWM Picking - view with final KPIs for FE'
 AS
SELECT
  client_id
	, wh_id
	, wh_nr
	, wh_task_nr
	, act_type
	, wh_task_item
	, wh_task_stat
	, conf_by
	, conf_dt
	, conf_tm
	, exc_cd
	, start_dt
	, start_tm
	, conf_tm_hh
	, act_dest_qty_auom
	, hu_type
	, dest_strg_bin
	, QUEUE
	, perf_area
	, act_area
	, wh_ord_nr
	, act_qty_auom_case
	, auom_case
	, dwh_created
	, dwh_updated
	, first_queue
	, rsrc
	, start_dt_who
	, start_tm_who
	, amt_pallet_ep 
	, amt_pallet
	, amt_case
	, amt_pick
	, skipped
	, grp_who_first
	, grp_who_last
	, grp_who_emp_first
	, grp_who_emp_last
	, pick_start_dt
	, pick_start_tm
	, pick_start_tm_hh
	, pick_end_dt
	, pick_end_tm
	, pick_end_tm_hh
	, work_tm_sec
	, sum_break_sec
FROM fe_mstr_logop.v_sapewm_picking_pick_rate_add;