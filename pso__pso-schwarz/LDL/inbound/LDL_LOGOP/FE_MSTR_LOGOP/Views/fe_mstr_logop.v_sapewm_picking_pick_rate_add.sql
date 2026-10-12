/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_picking_pick_rate_add
Description		|	SAP EWM Pick Rate - view with additional columns
====================================================================================================
*/

-- LDL_LOGOP_DEVELOPMENT.FE_MSTR_LOGOP.V_SAPEWM_PICKING_PICK_RATE_ADD source

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_PICKING_PICK_RATE_ADD(
	CLIENT_ID COMMENT 'Client id - calculated based on the country code',
	WH_ID COMMENT 'Warehouse ID. Subset of Warehouse Number',
	WH_NR COMMENT 'Warehouse Number/Warehouse Complex. Source column name: LGNUM',
	WH_TASK_NR COMMENT 'Warehouse Task. Source column name: TANUM',
	ACT_TYPE COMMENT 'Activity. Source column name: ACT_TYPE',
	WH_TASK_ITEM COMMENT 'Warehouse Task Item. Source column name: TAPOS',
	WH_TASK_STAT COMMENT 'Warehouse Task Status. Source column name: TOSTAT',
	CONF_BY COMMENT 'Confirmed by. Source column name: CONFIRMED_BY',
	CONF_DT COMMENT 'Confirmation Date. Source column name: CONFIRMED_DATE',
	CONF_TM COMMENT 'Confirmation Time. Source column name: CONFIRMED_TIME',
	EXC_CD COMMENT 'Exception Code. Source column name: EXCCODE',
	CONF_TM_HH COMMENT 'Confirmation time rounded down',
	START_DT COMMENT 'Start Date. Source column name: STARTED_DATE',
	START_TM COMMENT 'Start Time. Source column name: STARTED_TIME',
	SRC_HU COMMENT 'Source Handling Unit. Source column name: VLENR',
	ACT_DEST_QTY_AUOM COMMENT 'Actual Destination Quantity in Alternative Unit. Source column name: NISTA',
	AUOM COMMENT 'Alternative Unit of Measure for Stockkeeping Unit. Source column name: ALTME',
	HU_TYPE COMMENT 'Handling Unit Type. Source column name: LETYP',
	DEST_STRG_BIN COMMENT 'Destination Storage Bin. Source column name: NLPLA',
	QUEUE COMMENT 'Queue. Source column name: QUEUE',
	PERF_AREA COMMENT 'Performance area',
	ACT_AREA COMMENT 'Activity Area. Source column name: AAREA',
	WH_ORD_NR COMMENT 'Warehouse Order Number. Source column name: WHO',
	ACT_QTY_AUOM_CASE COMMENT 'Actual Quantity in Alternative Unit of Measure Case. Source column name: ZZ_QTY_CASE',
	AUOM_CASE COMMENT 'Alternative Unit of Measure Case. Source column name: ZZ_AUOM_CASE',
	DWH_CREATED COMMENT 'Record created at',
	DWH_UPDATED COMMENT 'Record updated at',
	FIRST_QUEUE COMMENT 'First queue within a warehouse order',
	WHO_STATUS COMMENT 'Warehouse Order Status. Source column name: STATUS',
	RSRC COMMENT 'Resource (Means of Transportation or User)',
	START_DT_WHO COMMENT 'Start Date. Source column name: STARTED_DATE',
	START_TM_WHO COMMENT 'Start Time. Source column name: STARTED_TIME',
	CONF_DT_WHO COMMENT 'Confirmation Date. Source column name: CONFIRMED_DATE',
	CONF_TM_WHO COMMENT 'Confirmation Time. Source column name: CONFIRMED_TIME',
	AMT_PALLET_EP COMMENT 'Amount of pallets in EP equivalent based on HU type',
	AMT_PALLET COMMENT 'Amount of pallets mit DEST_STRG_BIN',
	AMT_CASE COMMENT 'Amount of cases based on actual quantity in alternative unit case',
	AMT_PICK COMMENT 'Amount of picks based on actual destination quantity auom',
	SKIPPED COMMENT 'Skiped possition - warehouse task with the exeption codes “ZPPD, ZFPD, ZFPM”',
	GRP_QUEUE_FIRST COMMENT 'Identify the sequence of queues coming for picking',
	GRP_WHO_FIRST COMMENT 'Sorting number for group of WH order ascending',
	GRP_WHO_LAST COMMENT 'Sorting number for group of WH order descending',
	GRP_WHO_EMP_FIRST COMMENT 'Sorting number for group of WH order and employee ascending',
	GRP_WHO_EMP_LAST COMMENT 'Sorting number for group of WH order and employee descending',
	PICK_START_DT COMMENT 'Start date of pick',
	PICK_START_TM COMMENT 'Start time of pick',
	PICK_START_TM_HH COMMENT 'Starting hour of pick rounded down',
	PICK_END_DT COMMENT 'End date of pick',
	PICK_END_TM COMMENT 'End time of pick',
	PICK_END_TM_HH COMMENT 'Ending hour of pick rounded up',
	WORK_TM_SEC COMMENT 'Working time in seconds',
	SUM_BREAK_SEC COMMENT 'Sum of break time in secinds'
) AS
/*
 * Change Management: 
 * 2024-09-15 Pin Gao -Adding one column grp_queue_first to identify the sequence of queues changing. 
 *                    -Revise the logic for pick_start_tm 
 * 
 */
WITH 
 -- Marking the corresponding queue of the first WH task within a WH order  
 tasksfirstqueue AS (
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
	, src_hu
	, act_dest_qty_auom
	, auom
	, hu_type
	, dest_strg_bin
	, QUEUE
	, act_area
	, wh_ord_nr
	, act_qty_auom_case
	, auom_case
	, dwh_created
	, dwh_updated
	, FIRST_VALUE(QUEUE) OVER (PARTITION BY client_id, wh_id, wh_ord_nr ORDER BY conf_dt, conf_tm) AS first_queue -- queue of first WH task in WH order
	FROM fe_mstr_logop.v_sapewm_whtask -- Primary key (client_id, wh_nr, wh_task_nr, wh_task_item)
	WHERE wh_task_stat = 'C' -- confirmed
	AND act_type <> 'INTL' -- internal movements are not taken into account in SAP
),
 breaks AS (
 SELECT
	client_id
	, wh_id
	, crtd_by
	, wh_ord_nr
	, SUM (duration) AS break_sec -- break time in seconds 
	--, count (*) AS cnt_break
FROM fe_mstr_logop.v_sapewm_pickingbreak --PK (client_id, wh_id, crtd_by, start_dt, start_tm, who_nr)
GROUP BY 
client_id
	, wh_id
	, crtd_by
	, wh_ord_nr)
SELECT 
	t.client_id
	, t.wh_id
	, t.wh_nr
	, t.wh_task_nr
	, t.act_type
	, t.wh_task_item
	, t.wh_task_stat
	, t.conf_by
	, t.conf_dt
	, t.conf_tm
	, t.exc_cd
	, DATE_TRUNC('HOUR', t.conf_tm) AS conf_tm_hh
	, t.start_dt
	, t.start_tm
	, t.src_hu
	, t.act_dest_qty_auom
	, t.auom
	, t.hu_type
	, t.dest_strg_bin
	, t.QUEUE
	, q.perf_area
	, t.act_area
	, t.wh_ord_nr
	, t.act_qty_auom_case
	, t.auom_case
	, t.dwh_created
	, t.dwh_updated
	, t.first_queue
	, o.who_status
	, o.rsrc
	, o.start_dt AS start_dt_who
	, o.start_tm AS start_tm_who
	, o.conf_dt AS conf_dt_who
	, o.conf_tm AS conf_tm_who
	, DECODE(LEFT(t.hu_type, 2)
		, 'EP', TO_NUMBER(1, 10, 2)
		, 'DD', TO_NUMBER(0.5, 10, 2)
		, 'QP', TO_NUMBER(0.25, 10, 2)
		, 'SG', TO_NUMBER (1.28, 10,2)
		, 'HG', TO_NUMBER (0.5, 10, 2)
		, 'QG', TO_NUMBER (0.25, 10, 2)
		, 'BX', TO_NUMBER (1, 10, 2)
		, 'GMA', TO_NUMBER (1.28, 10, 2)
		, 'IP', TO_NUMBER (1.5, 10, 2)
		, 'BB', TO_NUMBER (0.04, 10, 2)
		, 'MT', TO_NUMBER (0.3, 10, 2)
		, 'AE', TO_NUMBER (1, 10, 2)
		, 'FR', TO_NUMBER (0.8, 10, 2)
		, TO_NUMBER(0, 10, 2)
		) AS amt_pallet_ep -- Amount of pallets in EP equivalent
	, IFF (dest_strg_bin IS NULL, '0', amt_pallet_ep) AS amt_pallet -- dest_strg_bin should not be NULL 
	, IFF (dest_strg_bin IS NOT NULL, '0', act_qty_auom_case) AS amt_case -- “PICK” warehouse tasks with a Destination Bin entry, that represent staging, should not be taken into account. 
	, IFF (dest_strg_bin IS NOT NULL, '0', act_dest_qty_auom) AS amt_pick -- “PICK” warehouse tasks with a Destination Bin entry, that represent staging, should not be taken into account. 
	, IFF (exc_cd IN ('ZPPD', 'ZFPD', 'ZFPM'), '1', NULL) AS skipped -- Skiped possition - warehouse task with the exeption codes “ZPPD, ZFPD, ZFPM”.
	, ROW_NUMBER() OVER (PARTITION BY t.client_id, t.wh_id, t.wh_ord_nr ORDER BY t.start_dt,t.start_tm) AS grp_queue_first
	, ROW_NUMBER() OVER (PARTITION BY t.client_id, t.wh_id, t.wh_ord_nr, t.conf_dt, t.QUEUE ORDER BY t.conf_dt ASC, t.conf_tm ASC, t.wh_task_nr ASC, t.wh_task_item ASC) AS grp_who_first -- To sort tasks/picks per wh order  
	, ROW_NUMBER() OVER (PARTITION BY t.client_id, t.wh_id, t.wh_ord_nr, t.QUEUE  ORDER BY t.conf_dt DESC, t.conf_tm DESC, t.wh_task_nr DESC, t.wh_task_item DESC) AS grp_who_last -- To sort tasks/picks per wh order  
	, ROW_NUMBER() OVER (PARTITION BY t.client_id, t.wh_id, t.wh_ord_nr, t.conf_by, t.QUEUE ORDER BY t.conf_dt ASC, t.conf_tm ASC, t.wh_task_nr ASC, t.wh_task_item ASC) AS grp_who_emp_first -- To sort tasks/picks per wh order and employee 
	, ROW_NUMBER() OVER (PARTITION BY t.client_id, t.wh_id, t.wh_ord_nr, t.conf_by, t.QUEUE ORDER BY t.conf_dt DESC, t.conf_tm DESC, t.wh_task_nr DESC, t.wh_task_item DESC) AS grp_who_emp_last -- To sort tasks/picks per wh order and employee
-- Start date and start time must additionally be differentiated by employee because of relevance of previous task confirmation 
	, CASE 
		WHEN grp_who_first = 1 AND grp_who_emp_first = 1 AND grp_queue_first = 1 AND t.QUEUE !='WHO_CANCEL' -- very first task per wh order 
			THEN start_dt_who 
		WHEN grp_who_first <> 1 AND grp_who_emp_first = 1 -- first task per wh order and employee in case of multiple employees 
			THEN t.conf_dt
		WHEN t.QUEUE = 'WHO_CANCEL' AND grp_who_first = 1 AND grp_who_emp_first = 1
			THEN t.start_dt
		ELSE LAG(t.conf_dt) OVER (PARTITION BY t.client_id, t.wh_id, t.wh_ord_nr, t.conf_by ORDER BY t.conf_dt ASC, t.conf_tm ASC, t.wh_task_nr ASC, t.wh_task_item ASC) -- per WH order and employee the confirmation date of the previous WH task
		END AS pick_start_dt
	, CASE 
		WHEN grp_who_first = 1 AND grp_who_emp_first = 1 AND grp_queue_first = 1 AND t.QUEUE !='WHO_CANCEL'
		THEN start_tm_who
		WHEN grp_who_first = 1 AND grp_who_emp_first = 1 AND t.QUEUE = 'WHO_CANCEL'
		THEN t.start_tm
		WHEN grp_who_first <>1 AND grp_who_emp_first = 1
		THEN t.conf_tm
	  ELSE LAG(t.conf_tm) OVER (PARTITION BY t.client_id, t.wh_id, t.wh_ord_nr, t.conf_by ORDER BY t.conf_dt ASC, t.conf_tm ASC, t.wh_task_nr ASC, t.wh_task_item ASC)
	END AS pick_start_tm -- start time of the WH order / task considering the sequence of queues
	, DATE_TRUNC('HOUR', pick_start_tm) AS pick_start_tm_hh -- Hour rounded down for start of picking time 
	, IFF(grp_who_last = 1 AND grp_who_emp_last = 1 -- very last task per wh order 
		,t.conf_dt -- usually conf_dt of WH order is also equal to conf_dt of last WH task 
		,t.conf_dt)
		AS pick_end_dt -- end date of the WH order / task 
	, IFF(grp_who_last = 1 AND grp_who_emp_last = 1 -- very last task per wh order
		,t.conf_tm -- conf_tm should be equal to conf_tm of last WH task and not WH order
		,t.conf_tm)
		AS pick_end_tm -- end time of the WH order / task 
	, DATEADD('HOUR', 1, DATE_TRUNC('HOUR', pick_end_tm)) AS pick_end_tm_hh -- Hour rounded up for end of picking time 
	, TIMEDIFF(SECOND, pick_start_dt, pick_end_dt) + TIMEDIFF(SECOND, pick_start_tm, pick_end_tm) AS work_tm_sec
	, IFF(grp_who_emp_last = 1 AND t.QUEUE = t.first_queue, b.break_sec, NULL) AS sum_break_sec -- break time per queue to avoid break time duplication
FROM tasksfirstqueue t -- Primary key (client_id, wh_nr, wh_task_nr, wh_task_item)
LEFT JOIN fe_mstr_logop.v_sapewm_whord o -- Primary key (client_id, wh_id, wh_ord_nr) 
		ON t.client_id = o.client_id
			AND t.wh_id = o.wh_id
			AND t.wh_ord_nr = o.wh_ord_nr
LEFT JOIN breaks b -- Primary key (client_id, wh_id, crtd_by, start_dt, start_tm, who_nr)
		ON t.client_id = b.client_id
			AND t.wh_id = b.wh_id
			AND t.wh_ord_nr = b.wh_ord_nr
			AND t.conf_by = b.crtd_by
LEFT JOIN fe_mstr_logop.v_lu_picking_queue_perfarea q -- Primary key (client_id, wh_id, wh_nr, queue)
		ON t.client_id = q.client_id
			AND t.wh_id = q.wh_id
			AND t.QUEUE = q.QUEUE; -- There can be more than one queue in one WH order but only the starting queue is relevant