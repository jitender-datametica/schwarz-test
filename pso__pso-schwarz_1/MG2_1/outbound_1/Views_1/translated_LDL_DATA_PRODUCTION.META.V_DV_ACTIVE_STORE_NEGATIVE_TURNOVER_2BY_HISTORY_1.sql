CREATE OR REPLACE VIEW ldl_data_production_meta.v_dv_active_store_negative_turnover_2by_history_1 (cal_dt, day_of_week,
int_org_sid, dwh_valid_from_tmsp, dwh_valid_to_tmsp, dwh_valid_fg, curr_int_org_nr, init_int_org_nr, int_org_name,
int_org_status_cd, int_org_status_descr, open_dt, planned_open_dt, close_dt, iso_country_cd, country_name, city_name,
district_name, zip, street_name, house_nr, lon, lat, po_box_nr, phone_nr, fax_nr, email_addr_txt, reporting_country_cd,
bus_dt, int_org_type_cd, country_org_cd, turnover_net_val, turnover_bytd_net_val, turnover_py_net_val,
turnover_py_bytd_net_val, turnover_py_swday_net_val, turnover_py_swday_bytd_net_val, sales_cnt, sales_qty, return_cnt,
return_qty, eod_turnover_net_val, booked_turnover_net_val, turnover_gross_val, turnover_bytd_gross_val,
turnover_py_gross_val, turnover_py_bytd_gross_val, turnover_py_swday_gross_val, turnover_py_swday_bytd_gross_val,
eod_turnover_gross_val, curr_cd, receipt_cnt, receipt_bytd_cnt, receipt_py_cnt, receipt_py_bytd_cnt,
receipt_py_swday_cnt, receipt_py_swday_bytd_cnt, cash_register_receipt_cnt, eod_receipt_cnt, booked_receipt_cnt,
failed_active_store_negative_revenue, total)
OPTIONS(DESCRIPTION = `ACTIVE STORES WITH DELIVERED (NEGATIVE) REVENUE OVER 2 BUSINESS YEARS HISTORY\\NINPUT DATASETS:\\NCORE_DIM.T_DIM_INTERNAL_ORGANIZATION_1\\NCORE_DIM.T_DIM_CALENDAR_DATE_1\\NCORE_DIM.T_DIM_REAL_ESTATE_1\\NCORE_DIM.T_FACT_RETAIL_BY_STORE_DAY_1`)
AS SELECT dt.cal_dt,
 dt.day_of_week,
 store.int_org_sid,
 store.dwh_valid_from_tmsp,
 store.dwh_valid_to_tmsp,
 store.dwh_valid_fg,
 store.curr_int_org_nr,
 store.init_int_org_nr,
 store.int_org_name,
 store.int_org_status_cd,
 store.int_org_status_descr,
 store.open_dt,
 store.planned_open_dt,
 store.close_dt,
 store.iso_country_cd,
 store.country_name,
 store.city_name,
 store.district_name,
 store.zip,
 store.street_name,
 store.house_nr,
 store.lon,
 store.lat,
 store.po_box_nr,
 store.phone_nr,
 store.fax_nr,
 store.email_addr_txt,
 store.reporting_country_cd,
 rev.bus_dt,
 rev.int_org_type_cd,
 rev.country_org_cd,
 rev.turnover_net_val,
 rev.turnover_bytd_net_val,
 rev.turnover_py_net_val,
 rev.turnover_py_bytd_net_val,
 rev.turnover_py_swday_net_val,
 rev.turnover_py_swday_bytd_net_val,
 rev.sales_cnt,
 rev.sales_qty,
 rev.return_cnt,
 rev.return_qty,
 rev.eod_turnover_net_val,
 rev.booked_turnover_net_val,
 rev.turnover_gross_val,
 rev.turnover_bytd_gross_val,
 rev.turnover_py_gross_val,
 rev.turnover_py_bytd_gross_val,
 rev.turnover_py_swday_gross_val,
 rev.turnover_py_swday_bytd_gross_val,
 rev.eod_turnover_gross_val,
 rev.curr_cd,
 rev.receipt_cnt,
 rev.receipt_bytd_cnt,
 rev.receipt_py_cnt,
 rev.receipt_py_bytd_cnt,
 rev.receipt_py_swday_cnt,
 rev.receipt_py_swday_bytd_cnt,
 rev.cash_register_receipt_cnt,
 rev.eod_receipt_cnt,
 rev.booked_receipt_cnt,
  CASE
  WHEN COALESCE(rev.turnover_net_val, 0) < 0
  THEN 1
  ELSE 0
  END AS failed_active_store_negative_revenue,
 1 AS total
FROM ldl_data_production_core_dim.t_dim_internal_organization_1 AS store
 INNER JOIN ldl_data_production_core_dim.t_dim_calendar_date_1 AS dt ON dt.cal_dt < CURRENT_DATE AND dt.bus_year_offset >=
   - 2
 INNER JOIN ldl_data_production_core_dim.t_dim_real_estate_1 AS re_1 ON store.int_org_sid = re.int_org_sid AND dt.cal_dt
    BETWEEN CAST(re.dwh_valid_from_tmsp AS DATE) AND (CAST(re.dwh_valid_to_tmsp AS DATE)) AND re.real_estate_status_cd =
   'OP'
 INNER JOIN ldl_data_production_core_dim.t_fact_retail_by_store_day_1 AS rev ON store.int_org_sid = rev.int_org_sid AND dt
   .cal_dt = rev.bus_dt
WHERE dt.cal_dt BETWEEN CAST(store.dwh_valid_from_tmsp AS DATE) AND (CAST(store.dwh_valid_to_tmsp AS DATE))
 AND LOWER(store.int_org_status_cd) = 'active'
 AND store.int_org_type_cd = 'STORE';