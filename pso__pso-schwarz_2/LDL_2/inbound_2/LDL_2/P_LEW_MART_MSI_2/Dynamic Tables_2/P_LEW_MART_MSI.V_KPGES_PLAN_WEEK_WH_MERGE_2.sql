
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_KPGES_PLAN_WEEK_WH_MERGE_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT 
   iweek.client_id, 
   iweek.org_unit_nr AS wh_id,  
   CASE WHEN iweek.org_type_id = 50 THEN 1 ELSE 2 END AS aspect_id, 
   iweek.indicator_id,  
   iweek.cy * 100 + iweek.cal_week AS cy_week,  
   CASE WHEN iweek.indicator_id IN (105,108,112,117,120,125,126,133,135,136,146,155,  
   156,157,158,161,162,163,168,169,170,172,174,177,179,203,204,209,210,212,216, 
   225,228,229,230,238,240,242,243,244,250,251,252,256,257,258,259,260,261,270, 
   271,272,273,276,280,281,282,283,284,286,288,289,151,293,302,304,306,308,310,312,314) 
   THEN iweek.val_indicator / cry.rate_currency_exchange ELSE iweek.val_indicator END AS val_indicator, 
   cry.currency_iso_cd, 
   iweek.dat_dayend 
  
   FROM p_lew_core_ac.v_wawi_indicator_week_2 AS iweek  
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS cry  
   ON  iweek.client_id = cry.client_id  
   AND iweek.org_type_id IN (50, 60)  
   AND iweek.indicator_type_id = 2  
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
    UNION ALL
/*--------------------------------------------------
-- include week level Kolli Indicator_id = 315 VGES
    Zweck:
    - Datenschutz für Kolli (Indicator_id = 315) dürfen auf Tagesebene (i_lew_bil.v_kpi_day_2) in dieser VIEW
      nicht ausgegeben werden.
    - Kollis werden auf Wochen (i_lew_mart_msi.v_kpges_week_wh_merge_2)
      und Monatsebene mit aufgenommen ( i_lew_mart_msi.v_kpges_mth_wh_merge_2)
--------------------------------------------------*/
 SELECT
 iweek.client_id
 , iweek.org_unit_nr AS wh_id
 -- BGES = 50 -> aspect_id = 1; VGES = 60 -> aspect_id = 2
 , CASE WHEN iweek.org_type_id = 50 THEN 1 ELSE 2 END AS aspect_id
 , iweek.indicator_id
 , iweek.cy_week
 , iweek.val_indicator
 , cry.currency_iso_cd
 , iweek.dat_dayend
 FROM
 (
    SELECT
        iday.client_id
    -- 50 = BGES; 60 = VGES
      , iday.org_type_id
      , iday.org_unit_nr
      , iday.indicator_id
      , cal.cy_week
      , SUM(iday.val_indicator) AS val_indicator
    ,  MAX( iday.dat_dayend ) AS dat_dayend
    FROM   p_lew_core_ac.v_wawi_indicator_day_2     AS iday
    INNER JOIN p_lew_core_ac.v_cal_calendarday_2  AS cal
        ON iday.dat_formdate = cal.cal_dt
     WHERE indicator_id IN (315)
     -- bges
     AND iday.org_type_id = 50
     GROUP BY 1,2,3,4,5
 ) AS iweek
 INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS cry
     ON  iweek.client_id = cry.client_id
     AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
;
