/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_whord_2
Description		|	SAP EWM - base view
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_whord_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code',
	lidl_ctry COMMENT 'Country_2 code. Original field name bic_zmlila',
	src_sys COMMENT 'Source system. Source column name: source_system',
	wh_id COMMENT 'Warehouse ID. Subset of Warehouse Number',
	wh_nr COMMENT 'Warehouse Number/Warehouse Complex. Source column name: LGNUM',
	wh_ord_nr COMMENT 'Warehouse Order Number. Source column name: WHO',
	wh_ord_crt_rule COMMENT 'Warehouse Order Creation Rule. Source column name: WCR',
	cat_wh_ord_crt_rule COMMENT 'Category of Warehouse Order Creation Rule. Source column name: CAT_TYPE',
	doc_hdr_wh_proc_type COMMENT 'Document Header Warehouse Process Type. Source column name: HDR_PROCTY',
	QUEUE COMMENT 'Queue',
	wave COMMENT 'Wave',
	who_status COMMENT 'Warehouse Order Status. Source column name: STATUS_2',
	act_area COMMENT 'Warehouse Order Activity Area. Source column name: AAREA',
	crtd_by COMMENT 'Created By. Source column name: CREATED_BY',
	crtd_on_dt COMMENT 'Created On. Source column name: CREATED_DATE',
	crtd_at_tm COMMENT 'Created At. Source column name: CREATED_TIME',
	processor COMMENT 'Processor',
	rsrc COMMENT 'Resource (Means of Transportation or User)',
	start_dt COMMENT 'Start Date. Source column name: STARTED_DATE',
	start_tm COMMENT 'Start Time. Source column name: STARTED_TIME',
	last_start_dt COMMENT 'Latest Start Date. Source column name: LS_DATE',
	last_start_tm COMMENT 'Latest Start Time. Source column name: LS_TIME',
	changed_by COMMENT 'Changed By',
	changed_on_dt COMMENT 'Changed On. Source column name: CHANGED_DATE',
	changed_at_tm COMMENT 'Changed At. Source column name: CHANGED_TIME',
	conf_by COMMENT 'Confirmed by. Source column name: CONFIRMED_BY',
	conf_dt COMMENT 'Confirmation Date. Source column name: CONFIRMED_DATE',
	conf_tm COMMENT 'Confirmation Time. Source column name: CONFIRMED_TIME',
	exec_tm_plan COMMENT 'Planned Execution Time of Warehouse Order. Source column name: PLANDURA',
	exec_tm_act COMMENT 'Actual Execution Time of Warehouse Order. Source column name: ACTDURA',
	who_tm_unit COMMENT 'Warehouse Order: Time Unit. Source column name: UNIT_T',
	wh_ord_nr_top COMMENT 'Warehouse Order Number of Higher-Level Warehouse Order. Source column name: TOPWHOID',
	wh_ord_nr_ref COMMENT 'Warehouse Order Number of Subsequent Warehouse Order. Source column name: REFWHOID',
	who_contains_pi_doc COMMENT 'WO Contains Physical Inventory Document. Source column name: FLGINV',
	who_contains_fg COMMENT 'WO Contains Warehouse Order. Source column name: FLGWHO',
	who_contains_wt COMMENT 'Warehouse Order Contains Warehouse Task. Source column name: FLGTO',
	who_log_nr COMMENT 'Warehouse Order Log Number. Source column name: WHOLOGNO',
	nr_wt COMMENT 'Number of WTs. Source column name: COUNT_TO',
	wt_tot COMMENT 'Total Weight. Source column name: SUM_WEIGHT',
	wt_unit COMMENT 'Weight Unit. Source column name: UNIT_W',
	vol_sum COMMENT 'Total Volume. Source column name: SUM_VOLUM',
	vol_unit COMMENT 'Volume Unit. Source column name: UNIT_V',
	total_processing_time COMMENT 'Total Processing Time. Source column name: SUM_REACHTIME',
	tm_unit COMMENT 'Time Unit. Source column name: UNIT_RT',
	pick_comp_dt COMMENT 'Planned Completion Date',
	pick_comp_tm COMMENT 'Planned Completion Time',
	wave_type COMMENT 'Wave Type',
	wh_ord_nr_split COMMENT 'Warehouse Order Number of WO That Was Split. Source column name: SPLITWHOID',
	who_split_fg COMMENT 'Warehouse Order Was Split. Source column name: WHO_SPLIT FLGSPLIT',
	hazard_substance COMMENT 'Hazardous Substance Relevant for Storage. Source column name: HAZMAT',
	start_bin COMMENT 'Starting Point for Processing Resource',
	who_dummy COMMENT 'Dummy_2 function in length 1. Source column name:WHO_DUMMY',
	store_nr COMMENT 'Store Number. Source column name: ZZ_SHIP_TO',
	store_name COMMENT 'Store Name. Source column name: ZZ_SHIP_TO_NAME',
	delay_stat_wh_queue COMMENT 'delay status_2 for WO in queue. Source column name: ZZ_STAG_DELAY',
	pshu_ind COMMENT 'PSHU Indicator. Source column name: ZZ_PSHU_IND',
	pshu_whohu COMMENT 'PSHU Guid from WHOHU. Source column name: ZZ_PSHU_WHOHU',
	pshu_hdr COMMENT 'PSHU Guid from Header. Source column name: ZZ_PSHU_HDR',
	dwh_load_id COMMENT 'Load id',
	dwh_created COMMENT 'Record created at',
	dwh_updated COMMENT 'Record updated at'
) COMMENT = 'SAP EWM - base view for warehouse order for BI Reporting'
AS
SELECT
	client_id
	, lidl_country AS lidl_ctry
	, source_system AS src_sys
	, wh_id 
	, lgnum AS wh_nr
	, who AS wh_ord_nr
	, wcr AS wh_ord_crt_rule
	, cat_type AS cat_wh_ord_crt_rule
	, hdr_procty AS doc_hdr_wh_proc_type
	, QUEUE 
	, wave
	, STATUS_2 AS who_status
	, aarea AS act_area
	, created_by AS crtd_by 
	, created_date AS crtd_on_dt
	, created_time AS crtd_at_tm
	, processor 
	, rsrc 
	, started_date AS start_dt
	, started_time AS start_tm
	, ls_date AS last_start_dt 
	, ls_time AS last_start_tm
	, changed_by 
	, changed_date AS changed_on_dt
	, changed_time AS changed_at_tm
	, confirmed_by AS conf_by
	, confirmed_date AS conf_dt
	, confirmed_time AS conf_tm
	, plandura AS exec_tm_plan 
	, actdura AS exec_tm_act
	, unit_t AS who_tm_unit
	, topwhoid AS wh_ord_nr_top
	, refwhoid AS wh_ord_nr_ref
	, flginv AS who_contains_pi_doc_fg
	, flgwho AS who_contains_wo_fg
	, flgto AS who_contains_wt_fg
	, whologno AS who_log_nr
	, count_to AS nr_wt
	, sum_weight AS wt_tot
	, unit_w AS wt_unit
	, sum_volum AS vol_sum
	, unit_v AS vol_unit
	, sum_reachtime AS total_processing_time
	, unit_rt AS tm_unit
	, pick_comp_date AS pick_comp_dt
	, pick_comp_time AS pick_comp_tm
	, wave_type
	, splitwhoid AS wh_ord_nr_split
	, flgsplit AS who_split_fg
	, hazmat AS hazard_substance
	, start_bin 
	, who_dummy
	, zz_ship_to AS store_nr
	, zz_ship_to_name AS store_name
	, zz_stag_delay AS delay_stat_wh_queue
	, zz_pshu_ind AS pshu_ind
	, zz_pshu_whohu AS pshu_whohu
	, zz_pshu_hdr AS pshu_hdr
	, dwh_load_id
	, dwh_created
	, dwh_updated
FROM DATA.t_sapewm_warehouseorder_2 -- PK (client_id, lgnum, who)
;
