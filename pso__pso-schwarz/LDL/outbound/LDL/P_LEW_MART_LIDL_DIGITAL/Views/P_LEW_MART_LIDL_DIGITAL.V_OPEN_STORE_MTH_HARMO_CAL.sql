/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface:
#            DDL for v_open_store_mth_harmo_cal
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------


#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-11-17 Patrick Mittler   Initial version 20211111_2971_st_open_mth_adj_hcal
#  1.2 2021-11-22 Patrick Mittler         Edit counting days for current month
#                                         and create comments
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_open_store_mth_harmo_cal (client_id, cy_month, harmo_cal_month_no,
reporting_start_dt, cm_open_store_cnt, cm_cnt_days_start_digital, cm_open_store_days_multiplied, pm_open_store_cnt,
pm_cnt_days_start_digital, pm_open_store_days_multiplied, pym_open_store_cnt, pym_cnt_days_start_digital,
pym_open_store_days_multiplied) AS /* Multiplie count of stores * count of days */
/* PM Multiplie count of stores * count of days */ /* PM Multiplie count of stores * count of days */ SELECT som.client_id
 ,
 som.cy_month,
 COALESCE(hc.harmo_cal_month_no, - 1) AS harmo_cal_month_no,
 cc.reporting_start_dt,
 som.cm_mth_ending_str_open_fg AS cm_open_store_cnt,
  CASE
  WHEN hc.cy_month = cc.cy_month /* includes day of reporting_start */
  THEN hc.last_day_of_month_no - EXTRACT(DAY FROM cc.reporting_start_dt) + 1
  ELSE CASE
   WHEN hc.cy_month > cc.cy_month AND MM.cy_month_seq <> 0 /* full days of month; except start and current month */
   THEN hc.last_day_of_month_no /* for current month only count days until yesterday */
   ELSE hc.last_day_of_month_no - 1
   END
  END AS cm_cnt_days_start_digital,
  som.cm_mth_ending_str_open_fg * CASE
   WHEN hc.cy_month = cc.cy_month
   THEN hc.last_day_of_month_no - EXTRACT(DAY FROM cc.reporting_start_dt) + 1
   ELSE CASE
    WHEN hc.cy_month > cc.cy_month AND MM.cy_month_seq <> 0
    THEN hc.last_day_of_month_no
    ELSE hc.last_day_of_month_no - 1
    END
   END AS cm_open_store_days_multiplied,
 som.pm_mth_ending_str_open_fg AS pm_open_store_cnt,
  CASE
  WHEN pm_hc.cy_month = cc.cy_month
  THEN pm_hc.last_day_of_month_no - EXTRACT(DAY FROM cc.reporting_start_dt) + 1
  ELSE CASE
   WHEN pm_hc.cy_month > cc.cy_month
   THEN pm_hc.last_day_of_month_no
   ELSE NULL
   END
  END AS pm_cnt_days_start_digital,
  som.pm_mth_ending_str_open_fg * CASE
   WHEN pm_hc.cy_month = cc.cy_month
   THEN pm_hc.last_day_of_month_no - EXTRACT(DAY FROM cc.reporting_start_dt) + 1
   ELSE CASE
    WHEN pm_hc.cy_month > cc.cy_month
    THEN pm_hc.last_day_of_month_no
    ELSE NULL
    END
   END AS pm_open_store_days_multiplied,
 som.pym_mth_ending_str_open_fg AS pym_open_store_cnt,
  CASE
  WHEN pym_hc.cy_month = cc.cy_month
  THEN pym_hc.last_day_of_month_no - EXTRACT(DAY FROM cc.reporting_start_dt) + 1
  ELSE CASE
   WHEN pym_hc.cy_month > cc.cy_month
   THEN pym_hc.last_day_of_month_no
   ELSE NULL
   END
  END AS pym_cnt_days_start_digital,
  som.pym_mth_ending_str_open_fg * CASE
   WHEN pym_hc.cy_month = cc.cy_month
   THEN pym_hc.last_day_of_month_no - EXTRACT(DAY FROM cc.reporting_start_dt) + 1
   ELSE CASE
    WHEN pym_hc.cy_month > cc.cy_month
    THEN pym_hc.last_day_of_month_no
    ELSE NULL
    END
   END AS pym_open_store_days_multiplied
FROM (SELECT client_id,
   cy_month,
   IF(COUNT(DISTINCT CASE
       WHEN cm_mth_ending_str_open_fg = 1
       THEN move_to_store_id
       ELSE NULL
       END) = 0, NULL, COUNT(DISTINCT CASE
      WHEN cm_mth_ending_str_open_fg = 1
      THEN move_to_store_id
      ELSE NULL
      END)) AS cm_mth_ending_str_open_fg,
   IF(COUNT(DISTINCT CASE
       WHEN pm_mth_ending_str_open_fg = 1
       THEN move_to_store_id
       ELSE NULL
       END) = 0, NULL, COUNT(DISTINCT CASE
      WHEN pm_mth_ending_str_open_fg = 1
      THEN move_to_store_id
      ELSE NULL
      END)) AS pm_mth_ending_str_open_fg,
   IF(COUNT(DISTINCT CASE
       WHEN pym_mth_ending_str_open_fg = 1
       THEN move_to_store_id
       ELSE NULL
       END) = 0, NULL, COUNT(DISTINCT CASE
      WHEN pym_mth_ending_str_open_fg = 1
      THEN move_to_store_id
      ELSE NULL
      END)) AS pym_mth_ending_str_open_fg
  FROM ldl_p_lew_mart_lidl_digital.t_store_open_month AS SOM
  WHERE move_to_store_id <> - 1
   AND aspect_id = 2
  GROUP BY client_id,
   cy_month) AS som
 INNER JOIN ldl_p_lew_core_ac.v_cal_month AS MM ON som.cy_month = MM.cy_month AND MM.cy_month_seq <= 0
 LEFT JOIN (SELECT client_id,
   cy_month,
   harmo_cal_month_no,
   MAX(EXTRACT(DAY FROM cal_dt)) AS last_day_of_month_no,
   TRUNC(CAST(CAST(MAX(EXTRACT(DAY FROM cal_dt)) AS NUMERIC) / 7 AS BIGNUMERIC), 2) AS week_of_month_no
  FROM ldl_p_lew_mart_lidl_digital.t_harmo_calendar_ldpl_day AS H
  GROUP BY client_id,
   cy_month,
   harmo_cal_month_no) AS hc ON som.client_id = hc.client_id AND som.cy_month = hc.cy_month
 LEFT JOIN (SELECT EXTRACT(DAY FROM cal_dt) AS last_day_of_month_no,
   TRUNC(CAST(CAST(EXTRACT(DAY FROM cal_dt) AS NUMERIC) / 7 AS BIGNUMERIC), 2) AS week_of_month_no,
   harmo_cal_month_no,
   cy_month,
   client_id
  FROM ldl_p_lew_mart_lidl_digital.t_harmo_calendar_ldpl_day AS H
  WHERE last_day_month_fg = 1) AS pm_hc ON som.client_id = pm_hc.client_id AND MM.cy_month_prev_1m = pm_hc.cy_month
 LEFT JOIN (SELECT EXTRACT(DAY FROM cal_dt) AS last_day_of_month_no,
   TRUNC(CAST(CAST(EXTRACT(DAY FROM cal_dt) AS NUMERIC) / 7 AS BIGNUMERIC), 2) AS week_of_month_no,
   harmo_cal_month_no,
   cy_month,
   client_id
  FROM ldl_p_lew_mart_lidl_digital.t_harmo_calendar_ldpl_day AS H
  WHERE last_day_month_fg = 1) AS pym_hc ON som.client_id = pym_hc.client_id AND MM.cy_month_prev_1y = pym_hc.cy_month
 INNER JOIN (SELECT CC.client_id,
   CAL.cy_month,
   CC.reporting_start_dt
  FROM ldl_p_lew_process_ac.v_lidlplus_config_client AS CC
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON CC.reporting_start_dt = CAL.cal_dt
  GROUP BY CC.client_id,
   CC.reporting_start_dt,
   CAL.cy_month) AS cc ON som.client_id = cc.client_id;