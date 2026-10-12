CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lpv_gd_pallet_rate_kpi_28days_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code (PK)'), wh_id
OPTIONS(description='Warehouse number (datastore_data:lagernummer). Foreign key: Referencing LPV.LAGER.LAGERNR'), op_id
OPTIONS(description='Surrogate key (PK)'), op_dt OPTIONS(description='Operation date from timestamp'), op_dt_prev
OPTIONS(description='Operation date of previous warehouse task'), op_tm
OPTIONS(description='Operation time from timestamp'), hr_ss OPTIONS(description='reference v_ref_time_hour_1'), op_tm_prev
OPTIONS(description='Operation time of previous warehouse task'), prev_op_tm_diff_sec
OPTIONS(description='Time in seconds between last and current operation'), user_id
OPTIONS(description='User ID of the executing user. Foreign key: Referencing LPV.PERSONAL.PERSNR'), user_id_blk
OPTIONS(description='Block of User id for certain countries due to GDPR'), comp_id
OPTIONS(description='Computer that initiated the goods movement. Foreign key: References LPV.RECHNER.RECHNERID'),
src_area_nr OPTIONS(description='Source area. Foreign key: Referencing LPV.BEREICH.NR'), src_pallet_nr
OPTIONS(description='Number of the pallet on which the stock is located. Foreign key: References LPV.LHM.LHMNR'),
pallet_type OPTIONS(description='Indication if a pallet a DQ or not'), tgt_area_nr
OPTIONS(description='Target area. Foreign key: Referencing LPV.BEREICH.NR'), dwh_updated
OPTIONS(description='Timeframe when the record was updated'), cons_src_area_nr
OPTIONS(description='Consolidated source area number'), mvmt_type_nr OPTIONS(description='Movement type for FE lookup'),
emp_wrk_shift_start_fg OPTIONS(description='Flag for first operation of a working shift of an employee_1'), work_tm_sec
OPTIONS(description='Recorded working time in seconds'), work_tm_sec_net
OPTIONS(description='Net working time in seconds without pauses and with standard time'), count_pallet_mvmt
OPTIONS(description='Count of the pallet movement including DQ'), number_of_pallet_mvmt
OPTIONS(description='Flag to identify the movement of unique pallets within the certain time period including DQ')) AS
SELECT client_id,
 wh_id,
 op_id,
 op_dt,
 op_dt_prev,
 op_tm,
 TIME(CAST(TRIM(CONCAT(EXTRACT(HOUR FROM op_tm), ':00:00')) AS TIME)) AS hr_ss,
 op_tm_prev,
 prev_op_tm_diff_sec,
 user_id,
  CASE
  WHEN client_id IN (3, 8, 12, 13, 16, 17, 19, 20, 21, 22, 24, 26, 28)
  THEN user_id
  ELSE NULL
  END AS user_id_blk,
 comp_id,
 src_area_nr,
 src_pallet_nr,
 pallet_type,
 tgt_area_nr,
 dwh_updated,
 cons_src_area_nr,
 mvmt_type_nr,
 emp_wrk_shift_start_fg,
 work_tm_sec,
 work_tm_sec_net,
 count_pallet_mvmt,
 number_of_pallet_mvmt
FROM ldl_logop_fe_mstr_logop.v_lpv_forklift_productivity_add_28days_1
WHERE op_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 28 DAY) AND (CURRENT_DATE);