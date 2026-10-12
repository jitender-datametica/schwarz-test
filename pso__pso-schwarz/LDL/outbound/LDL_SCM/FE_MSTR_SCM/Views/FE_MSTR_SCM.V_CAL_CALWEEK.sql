CREATE OR REPLACE VIEW ldl_scm_fe_mstr_scm.v_cal_calweek (cal_week, busyear, cal_month) AS SELECT DISTINCT cy_week AS
 cal_week,
 busyear,
 cy_month AS cal_month
FROM ldl_scm_core_rel.v_cal_calendarday;