CREATE OR REPLACE DYNAMIC TABLE  P_LEW_MART_MSI.V_ADV_INT
(
cy
,adv_week_int
,adv_wt_nr_int
,cy_week
,client_id
,country_iso_cd
,wh_id
,week_adv
,dat_adv      
)

TARGET_LAG = '1 hour, 30 minutes' -- dummy value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT
cal.cy                  AS cy            -- Kalenderjahr
,MOD( cal.cy_week, 100) AS adv_week_int  -- Werbeterminwoche
,CASE cal.day_of_week
   WHEN 1 THEN 1
   WHEN 2 THEN 1
   WHEN 6 THEN 3
   WHEN 7 THEN 3
   ELSE 2
 END                  AS adv_wt_nr_int -- Werbeterminwoche
,cal.cy_week  AS cy_week    -- zugehorige Woche
,adv.client_id,
co.country_iso_cd,
wh.src_wh_id AS wh_id                                             -- BGES
,Trim(   'KW '
      || Trim(adv_week_int)
      || ' / '
      || Trim(adv_wt_nr_int)
      || '  '
      || Trim(cy)
     )                          AS week_adv        -- Werbetermin BGES
,adv.dat_adv                                           -- Werbetermindatum BGES

FROM
(SELECT
adv.client_id
,adv.wh_loc_sid
,adv.dat_adv
FROM p_lew_core_ac.v_wawi_adv_item_advertising AS adv
UNION
SELECT
adv_s_ap.client_id
,adv_s_ap.wh_loc_sid
,adv_s_ap.dat_adv
FROM p_lew_core_ac.v_wawi_adv_item_advertising_s_ap AS adv_s_ap
) AS adv
 -- Auflösung WH
INNER JOIN p_lew_bil_ac.v_warehouse AS wh
ON wh.client_id = adv.client_id
AND wh.loc_sid_wh =  adv.wh_loc_sid
AND wh.dwh_actual_fg = 1

INNER JOIN p_lew_core_ac.v_cal_calendarday AS cal
ON  cal.cal_dt = adv.dat_adv
INNER JOIN p_lew_core_ac.v_wawi_ref_country AS co
ON  co.country_id = adv.client_id
GROUP BY
cal.cy
, adv_week_int
, adv_wt_nr_int
, cy_week
, adv.client_id
, co.country_iso_cd
, wh.src_wh_id
, week_adv
, adv.dat_adv
;





