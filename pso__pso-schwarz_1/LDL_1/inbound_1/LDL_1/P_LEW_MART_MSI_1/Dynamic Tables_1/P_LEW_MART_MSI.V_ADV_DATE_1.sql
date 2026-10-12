CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ADV_DATE_1
(
    client_id
   ,wh_id
   ,dat_adv
   ,week_adv
   ,day_of_week
   ,cy_week
   ,cy_month
   ,cy_year
   ,busyear
   ,rec_src_fg_std
   ,rec_src_fg_apt
)

TARGET_LAG = '1 hour, 30 minutes' -- dummy_1 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT
    d.client_id AS client_id
   ,d.wh_id AS wh_id
   ,d.dat_adv AS dat_adv
   ,SUBSTRING(Trim(cal.cy_week), 5, 2) || '/' ||  Trim(cal.day_of_week) || ' ' || Trim(cal.cy_week / 100) AS week_adv
   ,cal.day_of_week AS day_of_week
   ,cal.cy_week  AS cy_week
   ,cal.cy_month AS cy_month
   ,(cal.cy_week - MOD(cal.cy_week,100)) / 100 AS cy_year
   ,cal.busyear AS busyear
   ,Max(d.rec_src_fg_std) AS rec_src_fg_std
   ,Max(d.rec_src_fg_apt) AS rec_src_fg_apt
  FROM
  ( SELECT
      std.client_id
     ,wh.src_wh_id AS wh_id
     ,std.dat_adv
     ,std.week_adv
     ,Cast(NULL AS VARCHAR(10)) AS adv_desc_apt
     ,Cast('1' AS SMALLINT) AS rec_src_fg_std
     ,Cast('0' AS SMALLINT) AS rec_src_fg_apt
   FROM p_lew_core_ac.v_wawi_adv_item_advertising_1 AS  std
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
   ON wh.client_id = std.client_id
   AND wh.loc_sid_wh = std.wh_loc_sid
   AND wh.dwh_actual_fg = 1
GROUP BY std.client_id
   , wh.src_wh_id
   , std.dat_adv
   , std.week_adv

UNION ALL

SELECT
    apt.client_id
   ,wh.src_wh_id AS wh_id
   ,apt.dat_adv
   ,Cast(NULL AS VARCHAR(10)) AS adv_desc_std
   ,apt.dat_adv_desc AS adv_desc_apt
   ,Cast('0' AS SMALLINT) AS rec_src_fg_std
   ,Cast('1' AS SMALLINT) AS rec_src_fg_apt
   FROM p_lew_core_ac.v_wawi_adv_item_advertising_s_ap_1 AS apt /* Take only currently valid rows from base table */
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
   ON wh.client_id = apt.client_id
   AND wh.loc_sid_wh = apt.wh_loc_sid
   AND wh.dwh_actual_fg = 1
WHERE Current_Date BETWEEN apt.dat_rec_start AND apt.dat_rec_end
GROUP BY  apt.client_id
   , wh.src_wh_id
   , apt.dat_adv
   , apt.dat_adv_desc
) d
   INNER  JOIN p_lew_core_ac.v_cal_calendarday_1   AS cal
   ON  d.dat_adv = cal.cal_dt
   AND cal.cy < (SELECT Max(cy) - 6 FROM p_lew_core_ac.v_cal_calendarday_1)
   GROUP BY d.client_id
  , d.wh_id
  , d.dat_adv
  , SUBSTRING(Trim(cal.cy_week), 5, 2) || '/' ||  Trim(cal.day_of_week) || ' ' || Trim(cy_year)
   , cal.day_of_week
   , cal.cy_week
   , cal.cy_month
   , cal.busyear
;