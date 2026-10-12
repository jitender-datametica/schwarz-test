/*
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.1 2022-06-30 Pawel Wieczorek         AP0092849 Changing condition to cy_day_seq <= 1 to keep current date, adding comments 
#  1.2 2022-07-08 Pawel Wieczorek         AP0092849 Fixing not full pym
#  1.3 2022-07-11 Pawel Wieczorek         AP0092849 Fixing adjust growth cm and pm_2
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_calendar_ldlp_2 (client_id
OPTIONS(description='The surrogate key for a WAWI client.'), cal_dt OPTIONS(description='Calendar_2 date'), cy_week
OPTIONS(description='Week number'), next_cy_week OPTIONS(description='Next week number'), next_year_week
OPTIONS(description='Next year week number'), cy_month OPTIONS(description='Month number'), next_cy_month
OPTIONS(description='Next month number'), next_year_month OPTIONS(description='Next year month number'),
cw_harmo_cal_week_no OPTIONS(description='Current harmonized week no per country_2 - week since rollout'),
cw_adjust_growth_fg OPTIONS(description='Current week for adjust growth flag - berenigte steigerung'),
pw_harmo_cal_week_no OPTIONS(description='Previous harmonized week no per country_2 - week since rollout'),
pw_adjust_growth_fg OPTIONS(description='Previous week for adjust growth flag - berenigte steigerung'),
pyw_harmo_cal_week_no OPTIONS(description='Previous year week for harmonized week no per country_2 - week since rollout'),
pyw_adjust_growth_fg OPTIONS(description='Previous year week for adjust growth flag - berenigte steigerung'),
cm_harmo_cal_month_no OPTIONS(description='Current harmonized month no per country_2 - month since rollout'),
cm_adjust_growth_fg OPTIONS(description='Current month for adjust growth flag - berenigte steigerung'),
pm_harmo_cal_month_no OPTIONS(description='Previous harmonized month no per country_2 - month since rollout'),
pm_adjust_growth_fg OPTIONS(description='Previous month for adjust growth flag - berenigte steigerung'),
pym_harmo_cal_month_no
OPTIONS(description='Previous month week for Harmonized month no per country_2 - month since rollout'),
pym_adjust_growth_fg OPTIONS(description='Previous month week for adjust growth flag - berenigte steigerung'))
OPTIONS(DESCRIPTION = `CALENDAR_2 TABLE USED FOR KPI TRANSFORMATIONS IN LIDL DIGITAL TEAM`) AS WITH CTE_CAL AS (SELECT CFG
   .client_id,
   CAL.cal_dt,
   CAL.cy_week,
   CAL.cy_week_seq,
   CAL.cy_month,
   CAL.cy_month_seq,
   CAL.last_day_month_fg,
   CAL.cal_dt_prev_1y,
   CAL.cy_day_seq
  FROM ldl_p_lew_process_ac.v_lidlplus_config_client_2 AS CFG
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON CAL.cal_dt BETWEEN CFG.reporting_start_dt AND (DATE_ADD(CURRENT_DATE
      ,INTERVAL 31 DAY))
  WHERE CAL.cy_day_seq <= 1), CTE_CAL_CURRENT AS (SELECT client_id,
   cal_dt,
   cy_week,
   cy_month
  FROM CTE_CAL), CTE_CW AS (SELECT client_id,
   cal_dt,
   cy_week AS source_cy_week
  FROM CTE_CAL AS cal), CTE_PW AS (SELECT cal.client_id,
   cal.cal_dt,
   cal.cy_week AS source_cy_week,
   mm.next_cy_week
  FROM CTE_CAL AS cal
   INNER JOIN (SELECT cy_week_prev_1w,
     cy_week AS next_cy_week
    FROM ldl_p_lew_core_ac.v_cal_week_2
    WHERE cy_week_seq <= 0) AS mm_2 ON cal.cy_week = mm.cy_week_prev_1w), CTE_PYW AS (SELECT cal.client_id,
   cal.cal_dt,
   cal.cy_week AS source_cy_week,
   cal.next_year_week
  FROM (SELECT c.client_id,
     c.cal_dt,
     M.cy_week AS next_year_week,
     M.cy_week_prev_1y AS cy_week
    FROM CTE_CAL AS c
     INNER JOIN ldl_p_lew_core_ac.v_cal_week_2 AS M ON c.cy_week = M.cy_week_prev_1y
    WHERE /* next year week */ c.cy_week_seq <= 0) AS cal
   INNER JOIN ldl_p_lew_core_ac.v_cal_week_2 AS MM_2 ON cal.cy_week = MM.cy_week_prev_1y AND MM.cy_week_seq <= 0),
 CTE_FINAL_CAL_WK AS (SELECT COALESCE(cw.client_id, pw.client_id, pyw.client_id) AS client_id,
   COALESCE(cw.cal_dt, pw.cal_dt, pyw.cal_dt) AS cal_dt,
   COALESCE(cw.source_cy_week, pw.source_cy_week, pyw.source_cy_week) AS source_cy_week,
   pw.next_cy_week,
   pyw.next_year_week
  FROM CTE_CW AS cw
   FULL JOIN CTE_PW AS pw ON cw.client_id = pw.client_id AND cw.cal_dt = pw.cal_dt
   FULL JOIN CTE_PYW AS pyw ON cw.client_id = pyw.client_id AND cw.cal_dt = pyw.cal_dt), CTE_HARM_WK AS (SELECT
   client_id,
   cy_week,
   MAX(harmo_cal_week_no) AS harmo_cal_week_no
  FROM ldl_p_lew_mart_lidl_digital.t_harmo_calendar_ldpl_day_2
  GROUP BY client_id,
   cy_week), CTE_CM AS (SELECT client_id,
   cal_dt,
   cy_month AS source_cy_month
  FROM CTE_CAL AS cal), CTE_PM AS (SELECT cal.client_id,
   cal.cal_dt,
   cal.cy_month AS source_cy_month,
   mm.next_cy_month
  FROM CTE_CAL AS cal
   INNER JOIN (SELECT cy_month_prev_1m,
     cy_month AS next_cy_month
    FROM ldl_p_lew_core_ac.v_cal_month_2
    WHERE cy_month_seq <= 0) AS mm_2 ON cal.cy_month = mm.cy_month_prev_1m), CTE_PYM AS (SELECT c.client_id,
    c.cal_dt_prev_1y AS cal_dt,
    PY.cy_month AS source_cy_month,
    MIN(c.cy_month) AS next_year_month,
    MIN(c.cal_dt) AS next_year_day
   FROM CTE_CAL AS c
    INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS PY ON c.cal_dt_prev_1y = PY.cal_dt
   WHERE c.cy_month_seq <= 0
   GROUP BY c.client_id,
    cal_dt,
    source_cy_month
   UNION ALL
   SELECT c.client_id,
    DATE_ADD(c.cal_dt_prev_1y, INTERVAL 1 DAY) AS cal_dt,
    PY.cy_month AS source_cy_month,
    c.cy_month AS next_year_month,
    c.cal_dt AS next_year_day
   FROM CTE_CAL AS c
    INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS PY ON c.cal_dt_prev_1y = PY.cal_dt
   WHERE c.last_day_month_fg = 1
    AND PY.last_day_month_fg = 0
    AND /* it is not the last day of the month */ c.cy_month_seq <= 0), CTE_FINAL_CAL_MTH AS (SELECT COALESCE(cw.client_id
    , pw.client_id, pyw.client_id) AS client_id,
   COALESCE(cw.cal_dt, pw.cal_dt, pyw.cal_dt) AS cal_dt,
   COALESCE(cw.source_cy_month, pw.source_cy_month, pyw.source_cy_month) AS source_cy_month,
   pw.next_cy_month,
   pyw.next_year_month,
   pyw.next_year_day
  FROM CTE_CM AS cw
   FULL JOIN CTE_PM AS pw ON cw.client_id = pw.client_id AND cw.cal_dt = pw.cal_dt
   FULL JOIN CTE_PYM AS pyw ON cw.client_id = pyw.client_id AND cw.cal_dt = pyw.cal_dt), CTE_HARM_MTH AS (SELECT
   client_id,
   cy_month,
   MAX(harmo_cal_month_no) AS harmo_cal_month_no
  FROM ldl_p_lew_mart_lidl_digital.t_harmo_calendar_ldpl_day_2
  GROUP BY client_id,
   cy_month) (/* +31 to keep next month */
  /* the same cy_week for two years
                    days of two years are marked as last_day_week_fg
    
                        December 2019             January 2020
                    Su Mo Tu We Th Fr Sa      Su Mo Tu We Th Fr Sa
                    29 30 31                            1  2  3  4 */
  /* only full weeks */
  /* the same cy_month for two years
                    days of two years are marked as last_day_month_fg
    
                        December 2019             January 2020
                    Su Mo Tu We Th Fr Sa      Su Mo Tu We Th Fr Sa
                    29 30 31                            1  2  3  4 */
  /* pym calender */ /* in the next year could be 29, so we want to skip it */ /* missing 29 day of February */ SELECT
   cal.client_id,
   cal.cal_dt,
   cw.source_cy_week AS cy_week,
   cw.next_cy_week,
   cw.next_year_week,
   cm.source_cy_month AS cy_month,
   cm.next_cy_month,
   cm.next_year_month,
   COALESCE(cw_h.harmo_cal_week_no, - 1) AS cw_harmo_cal_week_no,
   COALESCE(CW_AG.adjust_growth_wk_fg, - 1) AS cw_adjust_growth_fg,
   COALESCE(pw_h.harmo_cal_week_no, - 1) AS pw_harmo_cal_week_no,
   COALESCE(PW_AG.adjust_growth_wk_fg, - 1) AS pw_adjust_growth_fg,
   COALESCE(pyw_h.harmo_cal_week_no, - 1) AS pyw_harmo_cal_week_no,
   COALESCE(PYW_AG.adjust_growth_wk_fg, - 1) AS pyw_adjust_growth_fg,
   COALESCE(cm_h.harmo_cal_month_no, - 1) AS cm_harmo_cal_month_no,
   COALESCE(CM_AG.adjust_growth_mth_fg, - 1) AS cm_adjust_growth_fg,
   COALESCE(pm_h.harmo_cal_month_no, - 1) AS pm_harmo_cal_month_no,
   COALESCE(PM_AG.adjust_growth_pm_fg, - 1) AS pm_adjust_growth_fg,
   COALESCE(pym_h.harmo_cal_month_no, - 1) AS pym_harmo_cal_month_no,
   COALESCE(PYM_AG.adjust_growth_mth_fg, - 1) AS pym_adjust_growth_fg
  FROM CTE_CAL_CURRENT AS cal
   LEFT JOIN CTE_FINAL_CAL_WK AS cw ON cal.client_id = cw.client_id AND cal.cal_dt = cw.cal_dt
   LEFT JOIN CTE_HARM_WK AS cw_h ON cw.client_id = cw_h.client_id AND cw.source_cy_week = cw_h.cy_week
   LEFT JOIN ldl_p_lew_mart_lidl_digital.t_adjust_growth_cal_ldpl_day_2 AS CW_AG ON cw.client_id = CW_AG.client_id AND cw
      .source_cy_week = CW_AG.cy_week AND CW_AG.day_of_week = 1 /* pw */
   LEFT JOIN CTE_HARM_WK AS pw_h ON cw.client_id = pw_h.client_id AND cw.next_cy_week = pw_h.cy_week
   LEFT JOIN ldl_p_lew_mart_lidl_digital.t_adjust_growth_cal_ldpl_day_2 AS PW_AG ON cw.client_id = PW_AG.client_id AND cw
      .next_cy_week = PW_AG.cy_week AND PW_AG.day_of_week = 1 /* pyw */
   LEFT JOIN CTE_HARM_WK AS pyw_h ON cw.client_id = pyw_h.client_id AND cw.next_year_week = pyw_h.cy_week
   LEFT JOIN ldl_p_lew_mart_lidl_digital.t_adjust_growth_cal_ldpl_day_2 AS PYW_AG ON cw.client_id = PYW_AG.client_id AND
      cw.next_year_week = PYW_AG.cy_week AND PYW_AG.day_of_week = 1
   LEFT JOIN CTE_FINAL_CAL_MTH AS cm ON cal.client_id = cm.client_id AND cal.cal_dt = cm.cal_dt /* cm */
   LEFT JOIN CTE_HARM_MTH AS cm_h ON cm.client_id = cm_h.client_id AND cm.source_cy_month = cm_h.cy_month
   LEFT JOIN ldl_p_lew_mart_lidl_digital.t_adjust_growth_cal_ldpl_day_2 AS CM_AG ON cal.client_id = CM_AG.client_id AND
     cal.cal_dt = CM_AG.cal_dt /* pm_2 */
   LEFT JOIN CTE_HARM_MTH AS pm_h ON cm.client_id = pm_h.client_id AND cm.next_cy_month = pm_h.cy_month
   LEFT JOIN ldl_p_lew_mart_lidl_digital.t_adjust_growth_cal_ldpl_day_2 AS PM_AG ON cm.client_id = PM_AG.client_id AND cm
      .next_cy_month = PM_AG.cy_month AND PM_AG.day_of_month = 1 /* pym */
   LEFT JOIN CTE_HARM_MTH AS pym_h ON cm.client_id = pym_h.client_id AND cm.next_year_month = pym_h.cy_month
   LEFT JOIN ldl_p_lew_mart_lidl_digital.t_adjust_growth_cal_ldpl_day_2 AS PYM_AG ON cm.client_id = PYM_AG.client_id AND
     cm.next_year_day = PYM_AG.cal_dt);