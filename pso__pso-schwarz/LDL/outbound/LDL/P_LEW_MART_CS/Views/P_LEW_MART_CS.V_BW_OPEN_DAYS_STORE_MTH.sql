/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_OPEN_DAYS_STORE_MTH
#----------------------------------------------------------------------------
# History:
#  1.0  12.05.2023    Ulrich Ross               Init, User Story 476747
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_open_days_store_mth(
   calmonth  
  ,client_id
  ,sumdaycount
  ,sumdaycount_ytd
) 
 AS WITH OPEN_DAYS_STORE_MTH AS (SELECT CAL.cy_month,
   STORE_MERGE.client_id,
   SUM(CNT_STORE_WEEK.day_cnt) AS day_cnt
  FROM ldl_p_lew_mart_msi_ac.v_day_cnt_store_week AS CNT_STORE_WEEK
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday AS CAL ON CNT_STORE_WEEK.dat_calendar = CAL.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_merge AS STORE_MERGE ON CNT_STORE_WEEK.client_id = STORE_MERGE.client_id
      AND CNT_STORE_WEEK.store_id = STORE_MERGE.store_id
  WHERE CAL.cy_month BETWEEN ROUND(CAST(FORMAT_DATE('%Y%m', DATE_ADD(CURRENT_DATE, INTERVAL - 6 YEAR)) AS BIGNUMERIC), 0
     ) AND (ROUND(CAST(FORMAT_DATE('%Y%m', CURRENT_DATE) AS BIGNUMERIC), 0))
   AND STORE_MERGE.aspect_id = 1
   AND STORE_MERGE.mis_store_active_fg = 1
   AND STORE_MERGE.dashboard_relevant_fg = 1
  GROUP BY CAL.cy_month,
   STORE_MERGE.client_id), OPEN_DAYS_STORE_DAY AS (SELECT CAL0.dat_calendar,
   STORE_MERGE0.client_id,
   STORE_MERGE0.store_id,
   SUM(CNT_STORE_DAY.day_cnt) AS day_cnt
  FROM ldl_p_lew_mart_msi_ac.v_day_cnt_store_week AS CNT_STORE_DAY
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_merge AS STORE_MERGE0 ON CNT_STORE_DAY.client_id = STORE_MERGE0.client_id
      AND CNT_STORE_DAY.store_id = STORE_MERGE0.store_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday AS CAL0 ON CNT_STORE_DAY.dat_calendar = CAL0.dat_calendar
  WHERE CAL0.cy_month BETWEEN ROUND(CAST(FORMAT_DATE('%Y%m', DATE_ADD(CURRENT_DATE, INTERVAL - 6 YEAR)) AS BIGNUMERIC),
     0) AND (ROUND(CAST(FORMAT_DATE('%Y%m', CURRENT_DATE) AS BIGNUMERIC), 0))
   AND STORE_MERGE0.aspect_id = 1
   AND STORE_MERGE0.mis_store_active_fg = 1
   AND STORE_MERGE0.dashboard_relevant_fg = 1
  GROUP BY STORE_MERGE0.store_id,
   STORE_MERGE0.client_id,
   CAL0.dat_calendar), OPEN_DAYS_STORE_DAY_BY_ACC AS (SELECT CAL1.cy_month,
   STORE_MERGE1.client_id,
   SUM(open_days_store_day.day_cnt) AS day_cnt_acc
  FROM OPEN_DAYS_STORE_DAY AS open_days_store_day
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_busyear_cum AS BY_ACC ON open_days_store_day.dat_calendar = BY_ACC.dat_byr_cum
    
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday AS CAL1 ON BY_ACC.dat_calendar = CAL1.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_all_store_merge AS STORE_MERGE1 ON open_days_store_day.client_id =
     STORE_MERGE1.client_id AND open_days_store_day.store_id = STORE_MERGE1.move_to_store_id
  WHERE STORE_MERGE1.aspect_id = 1
   AND STORE_MERGE1.dashboard_relevant_fg = 1
   AND BY_ACC.dat_calendar IN (SELECT MAX(dat_calendar) AS a692109121
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday AS CAL
     WHERE cy_month BETWEEN ROUND(CAST(FORMAT_DATE('%Y%m', DATE_ADD(CURRENT_DATE, INTERVAL - 6 YEAR)) AS BIGNUMERIC), 0
        ) AND (ROUND(CAST(FORMAT_DATE('%Y%m', CURRENT_DATE) AS BIGNUMERIC), 0))
     GROUP BY cy_month)
  GROUP BY CAL1.cy_month,
   STORE_MERGE1.client_id) (SELECT open_days_store_mth.cy_month,
   open_days_store_mth.client_id,
   open_days_store_mth.day_cnt AS sumdaycount,
   open_days_store_day_by_acc.day_cnt_acc AS sumdaycount_ytd
  FROM OPEN_DAYS_STORE_MTH AS open_days_store_mth
   FULL JOIN OPEN_DAYS_STORE_DAY_BY_ACC AS open_days_store_day_by_acc ON open_days_store_mth.client_id =
     open_days_store_day_by_acc.client_id AND open_days_store_mth.cy_month = open_days_store_day_by_acc.cy_month
  WHERE open_days_store_mth.cy_month IS NOT NULL);
