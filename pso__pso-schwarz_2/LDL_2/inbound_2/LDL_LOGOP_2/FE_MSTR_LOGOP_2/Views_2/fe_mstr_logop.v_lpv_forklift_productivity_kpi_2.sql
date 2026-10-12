/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_lpv_forklift_productivity_kpi_2
Description		|	LPV Forklift - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_lpv_forklift_productivity_kpi_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code (PK)'
	, wh_id COMMENT 'Warehouse number (datastore_data:lagernummer). Foreign key: Referencing LPV.LAGER.LAGERNR'
	, op_id COMMENT 'Surrogate key (PK)'
	, op_dt COMMENT 'Operation date from timestamp'
	, op_tm COMMENT 'Operation time from timestamp'
	, op_type COMMENT 'Operation type'
	, user_id COMMENT 'User ID of the executing user. Foreign key: Referencing LPV.PERSONAL.PERSNR'
	, comp_id COMMENT 'Computer that initiated the goods movement. Foreign key: References LPV.RECHNER.RECHNERID'
	, src_pallet_nr COMMENT 'Number of the pallet on which the stock is located. Foreign key: References LPV.LHM.LHMNR'
	, src_area_nr COMMENT 'Source area. Foreign key: Referencing LPV.BEREICH.NR'
	, tgt_area_nr COMMENT 'Target area. Foreign key: Referencing LPV.BEREICH.NR'
	, dwh_created COMMENT 'Record created at'
	, dwh_updated COMMENT 'Record updated at'
	, mvmt_fg COMMENT 'Flag for classification if the operation is a relevant movement'
	, cons_src_area_nr COMMENT 'Consolidated source area number'
	, mvmt_type_nr COMMENT 'Movement type for FE lookup'
	, op_dt_prev COMMENT 'Operation date of previous warehouse task'
	, op_tm_prev COMMENT 'Operation time of previous warehouse task'
	, prev_op_tm_diff_sec COMMENT 'Time in seconds between last and current operation'
	, emp_wrk_shift_start_fg COMMENT 'Flag for first operation of a working shift of an employee_2'
	, work_tm_sec COMMENT 'Recorded working time in seconds'
	, work_tm_sec_net COMMENT 'Net working time in seconds without pauses and with standard time'
	, count_pallet_mvmt COMMENT 'Amount of pallet movements'
	, number_of_pallet_mvmt COMMENT 'Number of pallet movements'
	)
COMMENT = 'LPV Forklift - view with final KPIs for FE (PK client_id, wh_id, op_id)'
AS 
SELECT
	client_id
	, wh_id
	, op_id
	, op_dt
	, op_tm
	, op_type
	, user_id
	, comp_id
	, src_pallet_nr
	, src_area_nr
	, tgt_area_nr
	, dwh_created
	, dwh_updated
	, mvmt_fg
	, cons_src_area_nr
	, mvmt_type_nr
	, op_dt_prev
	, op_tm_prev
	, prev_op_tm_diff_sec
	, emp_wrk_shift_start_fg
	, work_tm_sec
	, work_tm_sec_net
	, count_pallet_mvmt
	, number_of_pallet_mvmt
FROM fe_mstr_logop.v_lpv_forklift_productivity_add_2
;