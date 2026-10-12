CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_calendar_ldlp (client_id, cal_dt, cy_week, next_cy_week,
next_year_week, cy_month, next_cy_month, next_year_month, cw_harmo_cal_week_no, cw_adjust_growth_fg,
pw_harmo_cal_week_no, pw_adjust_growth_fg, pyw_harmo_cal_week_no, pyw_adjust_growth_fg, cm_harmo_cal_month_no,
cm_adjust_growth_fg, pm_harmo_cal_month_no, pm_adjust_growth_fg, pym_harmo_cal_month_no, pym_adjust_growth_fg)
OPTIONS(DESCRIPTION = `CALENDAR TABLE USED FOR KPI TRANSFORMATIONS IN LIDL DIGITAL TEAM`) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_calendar_ldlp;