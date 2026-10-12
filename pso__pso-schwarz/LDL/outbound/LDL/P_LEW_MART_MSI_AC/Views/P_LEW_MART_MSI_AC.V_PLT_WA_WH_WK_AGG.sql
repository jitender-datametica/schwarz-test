CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_plt_wa_wh_wk_agg (cy_week_partial_week_id, client_id, wh_id, aspect_id,
currency_iso_cd, business_yr, month_id, week_id, record_type, asis_plt_rcv_day1, asis_plt_rcv_day2, asis_plt_rcv_day3,
asis_plt_rcv_day4, asis_plt_rcv_day5, asis_plt_rcv_day6, asis_plt_rcv_day7, asis_plt_time_wa_day1, asis_plt_time_wa_day2
, asis_plt_time_wa_day3, asis_plt_time_wa_day4, asis_plt_time_wa_day5, asis_plt_time_wa_day6, asis_plt_time_wa_day7,
asis_plt_rcv_wk, asis_plt_rcv_mth, asis_plt_rcv_yr, asis_plt_time_wa_wk, asis_plt_time_wa_mth, asis_plt_time_wa_yr,
p1ycwd_plt_rcv_wk, p1ycmd_plt_rcv_mth, p1ycyd_plt_rcv_yr, p1ycwd_plt_time_wa_wk, p1ycmd_plt_time_wa_mth,
p1ycyd_plt_time_wa_yr, asis_plt_plan_rcv_mth, asis_plt_plan_rcv_yr, asis_plt_plan_time_wa_mth, asis_plt_plan_time_wa_yr
) AS SELECT *
FROM ldl_p_lew_mart_msi.v_plt_wa_wh_wk_agg;