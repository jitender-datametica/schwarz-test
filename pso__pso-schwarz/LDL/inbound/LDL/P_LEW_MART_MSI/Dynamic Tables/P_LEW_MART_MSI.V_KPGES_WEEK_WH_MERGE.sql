
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_KPGES_WEEK_WH_MERGE
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  18.12.2020    Mittler,Patrick          Add Kolli (ID 315) on Week-level
#  1.4  18.12.2020    Mittler,Patrick          set cy_day_seq to check current_date
#  1.5  06.01.2021    Mittler,Patrick          delete logic that exlcude actual week
#  1.6  06.01.2021    Mittler,Patrick          Add comments
#  1.7  06.01.2021    Mittler,Patrick          Add comments
#  1.8  07.01.2021    Mittler,Patrick          Edit val_indicator
#  1.9  07.01.2021    Mittler,Patrick          20201218_2694_Kolli_Wochen_Monitoring
#                                              REP1-14198
#  2.0  16.02.2021    Mittler,Patrick          20210216_2751_Wochmon_Transall_stdown
#                                              Anpassung Referenz Legacy currency_iso_cd
#  2.1  18.02.2021    Mittler,Patrick          20210216_2751_Wochmon_Transall_stdown
#                                              currency_exchange Anpassung
#  2.2  22.02.2021    Mittler,Patrick          20210222_2758_wk_moni_fix_cry
#                                              edit logic for 322 , 325
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_KPGES_WEEK_WH_MERGE 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT
   iweek.client_id, 
   iweek.org_unit_nr AS wh_id,  
   -- 50 = BGES
   -- 60 = VGES
   CASE WHEN iweek.org_type_id = 50 THEN 1 ELSE 2 END AS aspect_id, 
   iweek.indicator_id,  
   iweek.cy * 100 + iweek.cal_week AS cy_week,  
   CASE WHEN iweek.indicator_id IN (117,120,125,126,133,135,136,155,156,157,163,168,  
   169,170,172,174,177,179,203,204,209,210,212,216,228,229,230,238,240,242,250, 
   251,255,256,257,258,259,260,261,270,271,272,273,280,281,282,283,284,286) 
   THEN iweek.val_indicator / cry.rate_currency_exchange ELSE iweek.val_indicator END AS val_indicator, 
   cry.currency_iso_cd, 
   iweek.dat_dayend 
   FROM p_lew_core_ac.v_wawi_indicator_week AS iweek  
   INNER JOIN (
        SELECT
        b.client_id
        , curr_cd_from AS currency_iso_cd
        , curr_cd_to AS to_currency_iso_cd
        , exchange_rate AS rate_currency_exchange
        FROM         p_lew_core_ac.v_exchange_rate_known_hist     AS b
        INNER JOIN     p_lew_core_ac.v_exchange_rate_type             AS c
        ON c.client_id             = b.client_id
        AND c.x_rate_type_sid     = b.x_rate_type_sid
        AND c.src_kurst         = '@BEWE'
        WHERE   CURRENT_DATE BETWEEN b.active_from_dt AND b.active_to_dt
        AND     CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
    ) AS cry
 ON  iweek.client_id = cry.client_id
 AND iweek.indicator_type_id = 1
 AND iweek.org_type_id IN (50,60)
    UNION ALL
/*--------------------------------------------------
-- include week level Kolli Indicator_id = 315 VGES
    Zweck:
    - Datenschutz für Kolli (Indicator_id = 315) dürfen auf Tagesebene (i_lew_bil.v_kpi_day) in dieser VIEW
      nicht ausgegeben werden.
    - Kollis werden auf Wochen (i_lew_mart_msi.v_kpges_week_wh_merge)
      und Monatsebene mit aufgenommen ( i_lew_mart_msi.v_kpges_mth_wh_merge)
--------------------------------------------------*/
 SELECT
 iweek.client_id
 , iweek.org_unit_nr AS wh_id
 -- BGES = 50 -> aspect_id = 1; VGES = 60 -> aspect_id = 2
 , CASE WHEN iweek.org_type_id = 50 THEN 1 ELSE 2 END AS aspect_id
 , iweek.indicator_id
 , iweek.cy_week
 , iweek.val_indicator
 , 'EUR' AS currency_iso_cd
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
    FROM   p_lew_core_ac.v_wawi_indicator_day     AS iday
    INNER JOIN p_lew_core_ac.v_cal_calendarday  AS cal
        ON iday.dat_formdate = cal.cal_dt
     WHERE indicator_id IN (315)
     -- bges
     AND iday.org_type_id = 50
     GROUP BY 1,2,3,4,5
   UNION ALL 
   SELECT
        iday.client_id
    -- 50 = BGES; 60 = VGES
      , iday.org_type_id
      , iday.org_unit_nr
      , iday.indicator_id
      , cal.cy_week
      , SUM(iday.val_indicator) AS val_indicator
    ,  MAX( iday.dat_dayend ) AS dat_dayend
    FROM   p_lew_core_ac.v_wawi_indicator_day     AS iday
    INNER JOIN p_lew_core_ac.v_cal_calendarday  AS cal
        ON iday.dat_formdate = cal.cal_dt
     WHERE indicator_id IN (322, 325)
     -- bges
     AND iday.org_type_id IN (50,60)
     GROUP BY 1,2,3,4,5
 ) AS iweek;
