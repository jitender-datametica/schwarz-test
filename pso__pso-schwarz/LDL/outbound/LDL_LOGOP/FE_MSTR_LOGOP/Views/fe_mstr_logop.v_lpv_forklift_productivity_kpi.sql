/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_lpv_forklift_productivity_kpi
Description		|	LPV Forklift - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lpv_forklift_productivity_kpi (client_id
OPTIONS(description='Client id - calculated based on the country code (PK)'), wh_id
OPTIONS(description='Warehouse number (datastore_data:lagernummer). Foreign key: Referencing LPV.LAGER.LAGERNR'), op_id
OPTIONS(description='Surrogate key (PK)'), op_dt OPTIONS(description='Operation date from timestamp'), op_tm
OPTIONS(description='Operation time from timestamp'), op_type OPTIONS(description='Operation type'), user_id
OPTIONS(description='User ID of the executing user. Foreign key: Referencing LPV.PERSONAL.PERSNR'), comp_id
OPTIONS(description='Computer that initiated the goods movement. Foreign key: References LPV.RECHNER.RECHNERID'),
src_pallet_nr
OPTIONS(description='Number of the pallet on which the stock is located. Foreign key: References LPV.LHM.LHMNR'),
src_area_nr OPTIONS(description='Source area. Foreign key: Referencing LPV.BEREICH.NR'), tgt_area_nr
OPTIONS(description='Target area. Foreign key: Referencing LPV.BEREICH.NR'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), mvmt_fg
OPTIONS(description='Flag for classification if the operation is a relevant movement'), cons_src_area_nr
OPTIONS(description='Consolidated source area number'), mvmt_type_nr OPTIONS(description='Movement type for FE lookup'),
op_dt_prev OPTIONS(description='Operation date of previous warehouse task'), op_tm_prev
OPTIONS(description='Operation time of previous warehouse task'), prev_op_tm_diff_sec
OPTIONS(description='Time in seconds between last and current operation'), emp_wrk_shift_start_fg
OPTIONS(description='Flag for first operation of a working shift of an employee'), work_tm_sec
OPTIONS(description='Recorded working time in seconds'), work_tm_sec_net
OPTIONS(description='Net working time in seconds without pauses and with standard time'), count_pallet_mvmt
OPTIONS(description='Amount of pallet movements'), number_of_pallet_mvmt
OPTIONS(description='Number of pallet movements'))
OPTIONS(DESCRIPTION = `LPV FORKLIFT - VIEW WITH FINAL KPIS FOR FE (PK CLIENT_ID, WH_ID, OP_ID)`) AS SELECT client_id,
 wh_id,
 op_id,
 op_dt,
 op_tm,
 op_type,
 user_id,
 comp_id,
 src_pallet_nr,
 src_area_nr,
 tgt_area_nr,
 dwh_created,
 dwh_updated,
 mvmt_fg,
 cons_src_area_nr,
 mvmt_type_nr,
 op_dt_prev,
 op_tm_prev,
 prev_op_tm_diff_sec,
 emp_wrk_shift_start_fg,
 work_tm_sec,
 work_tm_sec_net,
 count_pallet_mvmt,
 number_of_pallet_mvmt
FROM ldl_logop_fe_mstr_logop.v_lpv_forklift_productivity_add;