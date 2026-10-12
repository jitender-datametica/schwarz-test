/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_CAL_CY_MONTH_WEEK_ROHERTRAGSLETTER_2
#----------------------------------------------------------------------------
# History:
#  1.0  26.04.2021    Marcin Malec             Created
#                                              https://jira.schwarz/browse/REP2-9469
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_cal_cy_month_week_rohertragsletter_2 AS SELECT A11.cy_week,
 A11.partialweek_in_mth_seq_asc AS week_in_mth,
  CASE
  WHEN A11.partialweek_in_mth_seq_asc = 1 AND A13.cy_week_sequence = 0
  THEN A11.cy_month - 1
  ELSE A11.cy_month
  END AS cy_month_rohertragsletter,
  (SELECT CWEEK.partialweek_in_mth_seq_asc
  FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS CDAY
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_partial_week_2 AS CWEEK ON CDAY.cy_week = CWEEK.cy_week AND CDAY.cy_month =
     CWEEK.cy_month
  WHERE CDAY.cy_day_sequence = 0) AS week_in_mth_current_seq,
  CASE
  WHEN (SELECT CWEEK0.partialweek_in_mth_seq_asc
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS CDAY0
      INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_partial_week_2 AS CWEEK0 ON CDAY0.cy_week = CWEEK0.cy_week AND CDAY0.cy_month
         = CWEEK0.cy_month
     WHERE CDAY0.cy_day_sequence = 0) = 1 AND A12.cy_month_sequence < 0
  THEN A12.cy_month_sequence + 1
  ELSE A12.cy_month_sequence
  END AS cy_month_sequence,
 A13.cy_week_sequence
FROM ldl_p_lew_mart_msi_ac.v_cal_partial_week_2 AS A11
 INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month_2 AS A12 ON A11.cy_month = A12.cy_month
 INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_week_2 AS A13 ON A11.cy_week = A13.cy_week;