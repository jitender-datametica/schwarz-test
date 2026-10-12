CREATE OR REPLACE VIEW ldl_data_production_eval.tmp_open_store_validation1_errors_1 (cal_dt, day_of_week, int_org_sid,
store_open_fg, dwh_valid_from_tmsp, dwh_valid_to_tmsp, dwh_valid_fg, curr_int_org_nr, init_int_org_nr, int_org_name,
int_org_status_cd, int_org_status_descr, open_dt, planned_open_dt, close_dt, iso_country_cd, country_name, city_name,
district_name, zip, street_name, house_nr, lon, lat, po_box_nr, phone_nr, fax_nr, email_addr_txt, bus_dt,
int_org_type_cd, country_org_cd, turnover_net_val, turnover_bytd_net_val, turnover_py_net_val, turnover_py_bytd_net_val
, turnover_py_swday_net_val, turnover_py_swday_bytd_net_val, sales_cnt, sales_qty, return_cnt, return_qty,
eod_turnover_net_val, booked_turnover_net_val, turnover_gross_val, turnover_bytd_gross_val, turnover_py_gross_val,
turnover_py_bytd_gross_val, turnover_py_swday_gross_val, turnover_py_swday_bytd_gross_val, eod_turnover_gross_val,
curr_cd, receipt_cnt, receipt_bytd_cnt, receipt_py_cnt, receipt_py_bytd_cnt, receipt_py_swday_cnt,
receipt_py_swday_bytd_cnt, cash_register_receipt_cnt, eod_receipt_cnt, booked_receipt_cnt,
failed_store_closed_delivered_revenue, total) AS SELECT *
FROM ldl_data_production_eval.tmp_open_store_validation1_1
WHERE failed_store_closed_delivered_revenue = 1;