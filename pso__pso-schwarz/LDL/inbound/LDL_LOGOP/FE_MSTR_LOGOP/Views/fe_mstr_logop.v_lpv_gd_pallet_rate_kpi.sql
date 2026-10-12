/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_lpv_gd_pallet_rate_kpi
Description		|	LPV Gruppenleiter - View based on Forklift LPV
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LPV_GD_PALLET_RATE_KPI(
	CLIENT_ID COMMENT 'Client id - calculated based on the country code (PK)',
	WH_ID COMMENT 'Warehouse number (datastore_data:lagernummer). Foreign key: Referencing LPV.LAGER.LAGERNR',
	OP_ID COMMENT 'Surrogate key (PK)',
	OP_DT COMMENT 'Operation date from timestamp',
	OP_DT_PREV COMMENT 'Operation date of previous warehouse task',
	OP_TM COMMENT 'Operation time from timestamp',
	HR_SS COMMENT 'reference v_ref_time_hour',
	OP_TM_PREV COMMENT 'Operation time of previous warehouse task',
	PREV_OP_TM_DIFF_SEC COMMENT 'Time in seconds between last and current operation',
	USER_ID COMMENT 'User ID of the executing user. Foreign key: Referencing LPV.PERSONAL.PERSNR',
	USER_ID_BLK COMMENT 'Block of User id for certain countries due to GDPR',
	COMP_ID COMMENT 'Computer that initiated the goods movement. Foreign key: References LPV.RECHNER.RECHNERID',
	SRC_AREA_NR COMMENT 'Source area. Foreign key: Referencing LPV.BEREICH.NR',
	SRC_PALLET_NR COMMENT 'Number of the pallet on which the stock is located. Foreign key: References LPV.LHM.LHMNR',
	PALLET_TYPE COMMENT 'Indication if a pallet a DQ or not',
	TGT_AREA_NR COMMENT 'Target area. Foreign key: Referencing LPV.BEREICH.NR',
	DWH_UPDATED COMMENT 'Timeframe when the record was updated',
	CONS_SRC_AREA_NR COMMENT 'Consolidated source area number',
	MVMT_TYPE_NR COMMENT 'Movement type for FE lookup',
	EMP_WRK_SHIFT_START_FG COMMENT 'Flag for first operation of a working shift of an employee',
	WORK_TM_SEC COMMENT 'Recorded working time in seconds',
	WORK_TM_SEC_NET COMMENT 'Net working time in seconds without pauses and with standard time',
	COUNT_PALLET_MVMT COMMENT 'Count of the pallet movement including DQ',
	NUMBER_OF_PALLET_MVMT COMMENT 'Flag to identify the movement of unique pallets within the certain time period including DQ'
) AS
SELECT 
	 client_id
	,wh_id
	,op_id
	,op_dt
	,op_dt_prev
	,op_tm
	,to_time(CONCAT(HOUR(op_tm),':00:00')) AS hr_ss
	,op_tm_prev
	,prev_op_tm_diff_sec
	,user_id
	,CASE 
		WHEN client_id IN (3,8,12,13,16,17,19,21,22,24,26,28) THEN user_id
	 ELSE NULL 
	 END AS user_id_blk
	
	,comp_id
	,src_area_nr
	,src_pallet_nr
	,pallet_type 
	,tgt_area_nr
	,dwh_updated
	,cons_src_area_nr
	,mvmt_type_nr
	,emp_wrk_shift_start_fg
	,work_tm_sec
	,work_tm_sec_net
    ,count_pallet_mvmt	
    ,number_of_pallet_mvmt
FROM FE_MSTR_LOGOP.V_LPV_FORKLIFT_PRODUCTIVITY_ADD
WHERE op_dt BETWEEN CURRENT_DATE-28 AND CURRENT_DATE
;