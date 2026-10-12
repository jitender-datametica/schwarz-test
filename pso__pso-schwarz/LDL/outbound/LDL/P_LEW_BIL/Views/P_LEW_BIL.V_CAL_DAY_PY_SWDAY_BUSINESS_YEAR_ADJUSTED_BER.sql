/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface : DDL for P_LEW_BIL.V_CAL_DAY_PY_SWDAY_BUSINESS_YEAR_ADJUSTED_BER
#----------------------------------------------------------------------------
# History:
#  1.0  01.06.2021    Rekovsky, Marvin    Initial Version
#                                         20210601_2848_CalWeekBer_TransAll (REP1-14578)
#                                         Replacement for x_lew_core.t_wawi_cal_week_ber (Transall Shutdown)
#  2.0  02.16.2022    Jaroslaw Syrokosz   Correct logic, add PPPY columns - B-0011292A-AP0120280
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil.v_cal_day_py_swday_business_year_adjusted_ber AS SELECT DCD.cal_dt,
 DCD.cy_week_part,
 DCD.cal_dt_swday_prev_1y AS prev_cy_dat_calendar_swd_ber,
 DCD.cal_dt_swday_prev_2y AS prev_prev_cy_dat_calendar_swd_ber,
 DCD.cal_dt_swday_prev_3y AS prev_prev_prev_cy_dat_calendar_swd_ber,
  CASE
  WHEN MOD(CAST(DCD.cy AS BIGNUMERIC), 4) = 0 AND FORMAT_DATE('%F', DCD.cal_dt) LIKE '%02-29'
  THEN DATE_ADD(DCD.cal_dt_swday_prev_2y, INTERVAL - 2 DAY)
  ELSE ADJ1.incl_cal_dt
  END AS prev_cy_dat_calendar_swd_ber_cum,
  CASE
  WHEN MOD(CAST(DCD.cy AS BIGNUMERIC), 4) = 0 AND FORMAT_DATE('%F', DCD.cal_dt) LIKE '%02-29'
  THEN DATE_ADD(DCD.cal_dt_swday_prev_3y, INTERVAL - 2 DAY)
  ELSE ADJ2.incl_cal_dt
  END AS prev_prev_cy_dat_calendar_swd_ber_cum,
  CASE
  WHEN MOD(CAST(DCD.cy AS BIGNUMERIC), 4) = 0 AND FORMAT_DATE('%F', DCD.cal_dt) LIKE '%02-29'
  THEN DATE_ADD(DCD.cal_dt_swday_prev_4y, INTERVAL - 2 DAY)
  ELSE ADJ3.incl_cal_dt
  END AS prev_prev_prev_cy_dat_calendar_swd_ber_cum
FROM ldl_p_lew_bil_ac.v_dim_cal_day AS DCD
 LEFT JOIN ldl_p_lew_bil_ac.v_cal_day_py_swday_business_year_adjusted AS ADJ1 ON DCD.cal_dt = ADJ1.cal_dt AND ADJ1.bus_year_diff
    = 1
 LEFT JOIN ldl_p_lew_bil_ac.v_cal_day_py_swday_business_year_adjusted AS ADJ2 ON DCD.cal_dt = ADJ2.cal_dt AND ADJ2.bus_year_diff
    = 2
 LEFT JOIN ldl_p_lew_bil_ac.v_cal_day_py_swday_business_year_adjusted AS ADJ3 ON DCD.cal_dt = ADJ3.cal_dt AND ADJ3.bus_year_diff
    = 3
QUALIFY (ROW_NUMBER() OVER (PARTITION BY DCD.cal_dt ORDER BY CASE
       WHEN MOD(CAST(DCD.cy AS BIGNUMERIC), 4) = 0 AND FORMAT_DATE('%F', DCD.cal_dt) LIKE '%02-29'
       THEN DATE_ADD(DCD.cal_dt_swday_prev_2y, INTERVAL - 2 DAY)
       ELSE ADJ1.incl_cal_dt
       END IS NULL, CASE
       WHEN MOD(CAST(DCD.cy AS BIGNUMERIC), 4) = 0 AND FORMAT_DATE('%F', DCD.cal_dt) LIKE '%02-29'
       THEN DATE_ADD(DCD.cal_dt_swday_prev_2y, INTERVAL - 2 DAY)
       ELSE ADJ1.incl_cal_dt
       END, CASE
       WHEN MOD(CAST(DCD.cy AS BIGNUMERIC), 4) = 0 AND FORMAT_DATE('%F', DCD.cal_dt) LIKE '%02-29'
       THEN DATE_ADD(DCD.cal_dt_swday_prev_3y, INTERVAL - 2 DAY)
       ELSE ADJ2.incl_cal_dt
       END IS NULL, CASE
       WHEN MOD(CAST(DCD.cy AS BIGNUMERIC), 4) = 0 AND FORMAT_DATE('%F', DCD.cal_dt) LIKE '%02-29'
       THEN DATE_ADD(DCD.cal_dt_swday_prev_3y, INTERVAL - 2 DAY)
       ELSE ADJ2.incl_cal_dt
       END, CASE
       WHEN MOD(CAST(DCD.cy AS BIGNUMERIC), 4) = 0 AND FORMAT_DATE('%F', DCD.cal_dt) LIKE '%02-29'
       THEN DATE_ADD(DCD.cal_dt_swday_prev_4y, INTERVAL - 2 DAY)
       ELSE ADJ3.incl_cal_dt
       END IS NULL, CASE
       WHEN MOD(CAST(DCD.cy AS BIGNUMERIC), 4) = 0 AND FORMAT_DATE('%F', DCD.cal_dt) LIKE '%02-29'
       THEN DATE_ADD(DCD.cal_dt_swday_prev_4y, INTERVAL - 2 DAY)
       ELSE ADJ3.incl_cal_dt
       END)) = 1;