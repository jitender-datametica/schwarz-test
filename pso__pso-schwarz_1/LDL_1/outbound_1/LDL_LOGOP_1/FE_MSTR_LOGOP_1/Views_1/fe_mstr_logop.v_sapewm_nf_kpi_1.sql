/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_nf_kpi_1
Description		|	SAP EWM NF - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_nf_kpi_1 (scan_guid OPTIONS(description='Unofficial PK'),
client_id OPTIONS(description='Client id - calculated based on the country_1 code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number'), return_num OPTIONS(description='Return number'),
product_num OPTIONS(description='Product Number'), defect_flag OPTIONS(description='Flag: Is defect'), defect_flag_test
OPTIONS(description='TEST_1'), art_unkn_flag OPTIONS(description='Flag: Is article unknown'), is_in_ret_flag
OPTIONS(description='Flag: Is in return'), sale_flag OPTIONS(description='Flag: Is Special Sales_1'), is_unp_flag
OPTIONS(description='Flag: Is Unpacked'), non_sortable_flag OPTIONS(description='Flag: Non sortable'), qty
OPTIONS(description='Quantity per scan - always one'), unit_1 OPTIONS(description='Unit_1 of Measure'), station_id
OPTIONS(description='Id of Scan Station in NF counting process'), conf_dt OPTIONS(description='Created On'),
created_time OPTIONS(description='Created At'), conf_dt_short OPTIONS(description='Short time format'),
created_time_conv OPTIONS(description='Converted created_time for Time Filter'), created_by
OPTIONS(description='Created By'), undo_flag OPTIONS(description='Undo flag'), offline_flag
OPTIONS(description='Offline Sorting'), shift_flag OPTIONS(description='What shift did scan occured on'),
non_adv_def_flag OPTIONS(description='Non advised defect scan'), nr_2
OPTIONS(description='Flag: 2nd option for scan to be considered as Non Recall'), nr_2_ok
OPTIONS(description='Flag: Option for DEF'), nr_3 OPTIONS(description='Flag: 3rd consideration for NR/DEF'), nr_4_ok
OPTIONS(description='Flag: 4th consideration for NR/DEF'), nr_5_ok
OPTIONS(description='Flag: 5th consideration for NR/DEF'), time_selector
OPTIONS(description='Assort data in hourly buckets'), time_hour, time_date, time_month, time_year, time_minute,
time_week, multi_flag OPTIONS(description='Original Case/Multiplicator Quota Flag'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), op_dt_prev
OPTIONS(description='Operation date of previous warehouse task'), op_tm_prev
OPTIONS(description='Operation time of previous warehouse task'), prev_op_tm_diff_sec
OPTIONS(description='Time in seconds between last and current operation'), emp_wrk_shift_start_fg
OPTIONS(description='Flag for first operation of a working shift of an employee_1'), work_tm_sec
OPTIONS(description='Recorded working time in seconds'), work_tm_sec_net
OPTIONS(description='Net working time in seconds without pauses and with standard time'), ex_quan
OPTIONS(description='Expected Quantities from NFLIMOREPORT'), repeat_qty OPTIONS(description='Quantity for scans'))
OPTIONS(DESCRIPTION = `NF KPI VIEW BASED ON NF ADD VIEW`) AS SELECT scan_guid,
 client_id,
 wh_id,
 return_num,
 product_num,
 defect_flag,
  CASE
  WHEN defect_flag
  THEN 'X'
  ELSE 'N'
  END AS defect_flag_test,
 art_unkn_flag,
 is_in_ret_flag,
 sale_flag,
 is_unp_flag,
 non_sortable_flag,
 qty,
 unit_1,
 station_id,
 conf_dt,
 created_time,
 conf_dt_short,
 created_time_conv,
 created_by,
 undo_flag,
 offline_flag,
 shift_flag,
 non_adv_def_flag,
 nr_2,
 nr_2_ok,
 nr_3,
 nr_4_ok,
 nr_5_ok,
 time_selector,
 time_hour,
 time_date,
 time_month,
 time_year,
 time_minute,
 time_week,
 multi_flag,
 dwh_created,
 dwh_updated,
 op_dt_prev,
 op_tm_prev,
 prev_op_tm_diff_sec,
 emp_wrk_shift_start_fg,
 work_tm_sec,
 work_tm_sec_net,
 ex_quan,
 repeat_qty
FROM ldl_logop_fe_mstr_logop.v_sapewm_nf_add_1;