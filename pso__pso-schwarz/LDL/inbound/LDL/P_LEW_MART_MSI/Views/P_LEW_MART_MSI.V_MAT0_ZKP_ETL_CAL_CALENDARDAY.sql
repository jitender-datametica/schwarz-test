/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_mat0_zkp_etl_cal_calendarday
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding,Michael           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  01.03.2021    Wandtke,Andrzej          REP1-14365 20210301_2769_ZKP_VIE_CAL AP0087463 Use table v_cal_calendarday instead of v_wawi_cal_calendarday
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT0_ZKP_ETL_CAL_CALENDARDAY AS
SELECT
   cal_dt AS dat_calendar
  ,cal_dt_prev_1d
  ,cal_dt_prev_1y
  ,cal_dt_prev_2y
  ,day_of_week
  ,day_of_month
  ,day_of_cy
  ,cy_week
  ,cy_week_part
  ,cy_month
  ,cy
  ,busyear
  ,cy_day_seq
  ,cal_dt_swday_prev_1y
  ,cal_dt_swday_prev_1y_1w
  ,cy_month_seq
  ,cy_week_seq
  ,cal_dt_prev_7d
  ,cal_dt_prev_md
  ,cal_dt_prev_yd
  ,cal_dt_prev_py
FROM P_LEW_CORE_AC.v_cal_calendarday
;
