
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_CAL_BUSYEAR_CUM_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  09.09.2021    Rekovsky,Marvin          20210908_2926_TransAll_busyear_cum (REP1-14705): Replace obsolete object v_wawi_cal_busyear_cum_1 with BIL views
#  1.4  29.02.2024    Wandtke,Andrzej          BS0011292_cal_month_ber_leap_year: special case for for leap years
#  1.5  29.07.2024    Malec, Marcin            User Story 600884: [BE] - leap year and after leap year condition for v_cal_busyear_cum_1; adding connection to leap year Feb 29 as py and ppy
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_CAL_BUSYEAR_CUM_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT 
cal.cal_dt           AS dat_calendar
,CASE
    WHEN MOD(cal1.cy,4) = 0 AND EXTRACT(MONTH FROM cum.incl_cal_dt) =2 AND (EXTRACT(DAY FROM DATEADD(MONTH,-12,cum.incl_cal_dt)) = EXTRACT(DAY FROM cal1.cal_dt) -1  ) AND EXTRACT(YEAR FROM cal.cal_dt) = cal1.cy + 1  -- leap year 29 Feb py 
    THEN NULL
    WHEN MOD(cal1.cy,4) = 0 AND EXTRACT(MONTH FROM cum.incl_cal_dt) =2 AND (EXTRACT(DAY FROM DATEADD(MONTH,-24,cum.incl_cal_dt)) = EXTRACT(DAY FROM cal1.cal_dt) -1  ) AND EXTRACT(YEAR FROM cal.cal_dt) = cal1.cy + 2  -- leap year 29 Feb ppy
    THEN NULL
    ELSE cum.incl_cal_dt     
END AS dat_byr_cum
   --condition for leap years
,CASE
    WHEN MOD(cal.cy,4) = 0 AND EXTRACT(MONTH FROM cum.incl_cal_dt) =2 AND (EXTRACT(DAY FROM DATEADD(MONTH,-12,cum.incl_cal_dt)) = EXTRACT(DAY FROM cum.incl_cal_dt) -1  )  -- leap year 29 Feb cy
    THEN NULL 
    WHEN MOD(cal1.cy,4) = 0 AND EXTRACT(MONTH FROM cum.incl_cal_dt) =2 AND (EXTRACT(DAY FROM DATEADD(MONTH,-12,cum.incl_cal_dt)) = EXTRACT(DAY FROM cal1.cal_dt) -1  ) AND EXTRACT(YEAR FROM cal.cal_dt) = cal1.cy + 1  -- leap year 29 Feb py
    THEN cal1.cal_dt
    WHEN MOD(cal1.cy,4) = 0 AND EXTRACT(MONTH FROM cum.incl_cal_dt) =2 AND (EXTRACT(DAY FROM DATEADD(MONTH,-24,cum.incl_cal_dt)) = EXTRACT(DAY FROM cal1.cal_dt) -1  ) AND EXTRACT(YEAR FROM cal.cal_dt) = cal1.cy + 2  -- leap year 29 Feb ppy  
    THEN NULL
    ELSE cal1.cal_dt_prev_1y
END AS prev_dat_byr_cum
,CASE
    WHEN MOD(cal.cy,4) = 0 AND EXTRACT(MONTH FROM cum.incl_cal_dt) =2 AND (EXTRACT(DAY FROM DATEADD(MONTH,-24,cum.incl_cal_dt)) = EXTRACT(DAY FROM cum.incl_cal_dt) -1  )  -- leap year 29 Feb cy
    THEN NULL 
    WHEN MOD(cal1.cy,4) = 0 AND EXTRACT(MONTH FROM cum.incl_cal_dt) =2 AND (EXTRACT(DAY FROM DATEADD(MONTH,-12,cum.incl_cal_dt)) = EXTRACT(DAY FROM cal1.cal_dt) -1  ) AND EXTRACT(YEAR FROM cal.cal_dt) = cal1.cy + 1  -- leap year 29 Feb py
    THEN NULL
    WHEN MOD(cal1.cy,4) = 0 AND EXTRACT(MONTH FROM cum.incl_cal_dt) =2 AND (EXTRACT(DAY FROM DATEADD(MONTH,-24,cum.incl_cal_dt)) = EXTRACT(DAY FROM cal1.cal_dt) -1  ) AND EXTRACT(YEAR FROM cal.cal_dt) = cal1.cy + 2  -- leap year 29 Feb ppy
    THEN cal1.cal_dt
    ELSE cal1.cal_dt_prev_2y
END AS dat_busyear_cum_ppy
,cal.bus_year        AS byr
,cal.bus_year_offset AS cy_by_cum_sequence
FROM p_lew_bil_ac.v_dim_cal_day_1 AS cal
LEFT OUTER JOIN p_lew_bil_ac.v_cal_cum_business_year_to_date_1 AS cum
ON cal.cal_dt = cum.cal_dt
LEFT OUTER JOIN p_lew_bil_ac.v_dim_cal_day_1 AS cal1
ON ((cum.incl_cal_dt = cal1.cal_dt)
OR ((EXTRACT(YEAR FROM cal.cal_dt) = cal1.cy + 1 ) -- 29 Feb py
    AND (MOD(cal1.cy,4) = 0)
    AND (EXTRACT(MONTH FROM cal.cal_dt) = 2)
    AND (EXTRACT(MONTH FROM cal1.cal_dt) = 2)
    AND (cum.incl_cal_dt = cal.cal_dt)
    AND (EXTRACT(DAY FROM DATEADD(MONTH,-12,cal.cal_dt)) = EXTRACT(DAY FROM cal1.cal_dt) - 1 )
   )
OR ((EXTRACT(YEAR FROM cal.cal_dt) = cal1.cy + 2 ) -- 29 Feb ppy
    AND (MOD(cal1.cy,4) = 0)
    AND (EXTRACT(MONTH FROM cal.cal_dt) = 2)
    AND (EXTRACT(MONTH FROM cal1.cal_dt) = 2)
    AND (cum.incl_cal_dt = cal.cal_dt)
    AND (EXTRACT(DAY FROM DATEADD(MONTH,-12,cal.cal_dt)) = EXTRACT(DAY FROM cal1.cal_dt) - 1 )
   )
)
;
