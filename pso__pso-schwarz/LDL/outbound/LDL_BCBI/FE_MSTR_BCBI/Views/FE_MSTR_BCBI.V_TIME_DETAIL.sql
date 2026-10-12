CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_time_detail AS SELECT EX.client_id,
 EX.country_iso,
 EX.wh_id,
 EX.loc_sid_wh,
 EX.wh_desc,
 EX.wh_type,
 EX.loc_sid_store,
 EX.orig_store_nr,
 EX.store_desc,
 EX.dat_open,
 CALWEEK.week_of_year AS week,
 CALWEEK.cy_week_short_name AS week_name,
 CALWEEK.cy_week AS week_id,
 CALDAY.month_of_year AS month,
 CALDAY.month_of_year_name AS month_name,
 CALDAY.cy_month AS month_id,
 CALDAY.cy AS year,
 MAIN.work_time_gross_hr,
 MAIN.work_time_net_hr,
 MAIN.break_hr,
 MAIN.perform_relev_absence_hr,
 EX.source_system,
 PLAN.hours_total_cnt AS plan_hours_total_cnt,
 PLAN.hours_working_cnt AS plan_hours_working_cnt,
  MAIN.work_time_net_hr - PLAN.hours_total_cnt AS diff_hour,
  CASE
  WHEN PLAN.hours_total_cnt IS NULL OR PLAN.hours_total_cnt = 0
  THEN 0
  ELSE 1 - MAIN.work_time_net_hr / PLAN.hours_total_cnt
  END AS diff_hour_perc,
  CASE
  WHEN MAIN.work_time_net_hr IS NULL
  THEN 1
  ELSE 0
  END AS missing_fg,
  CASE
  WHEN CASE
    WHEN MAIN.work_time_net_hr IS NULL
    THEN 1
    ELSE 0
    END = 1
  THEN 'Fehlt'
  ELSE 'Erhalten'
  END AS missing_desc,
 CAST(ROUND(ABF.abverkauf, 0) AS INTEGER) AS abverkauf
FROM ldl_bcbi_fe_mstr_bcbi.v_time_store_expected_list AS EX
 LEFT JOIN ldl_bcbi_fe_mstr_bcbi.v_time_main AS MAIN ON EX.client_id = MAIN.client_id AND EX.loc_sid_store = MAIN.loc_sid_store
     AND EX.dat_open = MAIN.dwh_cal_dt
 LEFT JOIN ldl_bcbi_fe_mstr_bcbi.t_time_abverkauf AS ABF ON EX.client_id = ABF.client_id AND EX.loc_sid_store = ABF.loc_sid
     AND EX.dat_open = ABF.dwh_cal_dt
 LEFT JOIN ldl_bcbi_fe_mstr_bcbi.t_workingtime_plan_store_day AS PLAN ON EX.client_id = PLAN.client_id AND EX.loc_sid_store
     = PLAN.loc_sid_store AND EX.dat_open = PLAN.cal_dt
 LEFT JOIN ldl_bcbi_fe_mstr_bcbi.t_dim_cal_day AS CALDAY ON EX.dat_open = CALDAY.cal_dt
 LEFT JOIN ldl_bcbi_fe_mstr_bcbi.t_dim_cal_week AS CALWEEK ON CALDAY.cy_week = CALWEEK.cy_week;