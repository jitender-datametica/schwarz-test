/* Version: 1.0
    ** Author:  Stefan Sockel
    ** Date:    2022-11-09
    ** Changes: Initial version */
CREATE OR REPLACE VIEW ldl_fe_mstr_ai_reporting.v_cal_day_mtd_2 (dat_calendar, mtd_date) AS SELECT A.dat_calendar,
 B.dat_calendar AS mtd_date
FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS A
 INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS B ON A.day_of_month >= B.day_of_month AND A.cy_month = B.cy_month;