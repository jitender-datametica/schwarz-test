/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_CAL_BUSYEAR_CUM_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  09.09.2021    Rekovsky,Marvin          20210908_2926_TransAll_busyear_cum (REP1-14705): Replace obsolete object v_wawi_cal_busyear_cum_2 with BIL views
#  1.4  29.02.2024    Wandtke,Andrzej          BS0011292_cal_month_ber_leap_year: special case for for leap years
#  1.5  29.07.2024    Malec, Marcin            User Story 600884: [BE] - leap year and after leap year condition for v_cal_busyear_cum_2; adding connection to leap year Feb 29 as py and ppy
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_cal_busyear_cum_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
-- condition for leap years
 -- leap year 29 Feb cy
 -- leap year 29 Feb cy
 -- 29 Feb py
 -- 29 Feb ppy
 SELECT CAL.cal_dt
  AS dat_calendar,
  CASE
  WHEN MOD(CAST(CAL1.cy AS BIGNUMERIC), 4) = 0 AND EXTRACT(MONTH FROM CUM.incl_cal_dt) = 2 AND EXTRACT(DAY FROM DATE_ADD(CUM
       .incl_cal_dt, INTERVAL - 12 MONTH)) = EXTRACT(DAY FROM CAL1.cal_dt) - 1 AND EXTRACT(YEAR FROM CAL.cal_dt) = CAL1
     .cy + 1 -- leap year 29 Feb py

  THEN NULL
  WHEN MOD(CAST(CAL1.cy AS BIGNUMERIC), 4) = 0 AND EXTRACT(MONTH FROM CUM.incl_cal_dt) = 2 AND EXTRACT(DAY FROM DATE_ADD(CUM
       .incl_cal_dt, INTERVAL - 24 MONTH)) = EXTRACT(DAY FROM CAL1.cal_dt) - 1 AND EXTRACT(YEAR FROM CAL.cal_dt) = CAL1
     .cy + 2 -- leap year 29 Feb ppy

  THEN NULL
  ELSE CUM.incl_cal_dt
  END AS dat_byr_cum,
  CASE
  WHEN MOD(CAST(CAL.cy AS BIGNUMERIC), 4) = 0 AND EXTRACT(MONTH FROM CUM.incl_cal_dt) = 2 AND EXTRACT(DAY FROM DATE_ADD(CUM
      .incl_cal_dt, INTERVAL - 12 MONTH)) = EXTRACT(DAY FROM CUM.incl_cal_dt) - 1
  THEN NULL
  WHEN MOD(CAST(CAL1.cy AS BIGNUMERIC), 4) = 0 AND EXTRACT(MONTH FROM CUM.incl_cal_dt) = 2 AND EXTRACT(DAY FROM DATE_ADD(CUM
       .incl_cal_dt, INTERVAL - 12 MONTH)) = EXTRACT(DAY FROM CAL1.cal_dt) - 1 AND EXTRACT(YEAR FROM CAL.cal_dt) = CAL1
     .cy + 1 -- leap year 29 Feb py

  THEN CAL1.cal_dt
  WHEN MOD(CAST(CAL1.cy AS BIGNUMERIC), 4) = 0 AND EXTRACT(MONTH FROM CUM.incl_cal_dt) = 2 AND EXTRACT(DAY FROM DATE_ADD(CUM
       .incl_cal_dt, INTERVAL - 24 MONTH)) = EXTRACT(DAY FROM CAL1.cal_dt) - 1 AND EXTRACT(YEAR FROM CAL.cal_dt) = CAL1
     .cy + 2 -- leap year 29 Feb ppy

  THEN NULL
  ELSE CAL1.cal_dt_prev_1y
  END AS prev_dat_byr_cum,
  CASE
  WHEN MOD(CAST(CAL.cy AS BIGNUMERIC), 4) = 0 AND EXTRACT(MONTH FROM CUM.incl_cal_dt) = 2 AND EXTRACT(DAY FROM DATE_ADD(CUM
      .incl_cal_dt, INTERVAL - 24 MONTH)) = EXTRACT(DAY FROM CUM.incl_cal_dt) - 1
  THEN NULL
  WHEN MOD(CAST(CAL1.cy AS BIGNUMERIC), 4) = 0 AND EXTRACT(MONTH FROM CUM.incl_cal_dt) = 2 AND EXTRACT(DAY FROM DATE_ADD(CUM
       .incl_cal_dt, INTERVAL - 12 MONTH)) = EXTRACT(DAY FROM CAL1.cal_dt) - 1 AND EXTRACT(YEAR FROM CAL.cal_dt) = CAL1
     .cy + 1 -- leap year 29 Feb py

  THEN NULL
  WHEN MOD(CAST(CAL1.cy AS BIGNUMERIC), 4) = 0 AND EXTRACT(MONTH FROM CUM.incl_cal_dt) = 2 AND EXTRACT(DAY FROM DATE_ADD(CUM
       .incl_cal_dt, INTERVAL - 24 MONTH)) = EXTRACT(DAY FROM CAL1.cal_dt) - 1 AND EXTRACT(YEAR FROM CAL.cal_dt) = CAL1
     .cy + 2 -- leap year 29 Feb ppy

  THEN CAL1.cal_dt
  ELSE CAL1.cal_dt_prev_2y
  END AS dat_busyear_cum_ppy,
 CAL.bus_year AS byr,
 CAL.bus_year_offset AS cy_by_cum_sequence
FROM ldl_p_lew_bil_ac.v_dim_cal_day_2 AS CAL
 LEFT JOIN ldl_p_lew_bil_ac.v_cal_cum_business_year_to_date_2 AS CUM ON CAL.cal_dt = CUM.cal_dt
 LEFT JOIN ldl_p_lew_bil_ac.v_dim_cal_day_2 AS CAL1 ON CUM.incl_cal_dt = CAL1.cal_dt OR EXTRACT(YEAR FROM CAL.cal_dt) =
          CAL1.cy + 1 AND MOD(CAL1.cy, 4) = 0 AND EXTRACT(MONTH FROM CAL.cal_dt) = 2 AND EXTRACT(MONTH FROM CAL1.cal_dt
        ) = 2 AND CUM.incl_cal_dt = CAL.cal_dt AND EXTRACT(DAY FROM DATE_ADD(CAL.cal_dt, INTERVAL - 12 MONTH)) = EXTRACT(DAY
       FROM CAL1.cal_dt) - 1 OR EXTRACT(YEAR FROM CAL.cal_dt) = CAL1.cy + 2 AND MOD(CAL1.cy, 4) = 0 AND EXTRACT(MONTH
        FROM CAL.cal_dt) = 2 AND EXTRACT(MONTH FROM CAL1.cal_dt) = 2 AND CUM.incl_cal_dt = CAL.cal_dt AND EXTRACT(DAY
     FROM DATE_ADD(CAL.cal_dt, INTERVAL - 12 MONTH)) = EXTRACT(DAY FROM CAL1.cal_dt) - 1;
