
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_adv_int_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
-- Kalenderjahr
 -- Werbeterminwoche
 -- Werbeterminwoche
 -- zugehorige Woche_1
 -- BGES
 -- Werbetermin BGES

-- Werbetermindatum BGES
 -- Auflösung WH
 SELECT CAL.cy,
 MOD(CAST(CAL.cy_week AS BIGNUMERIC), 100) AS adv_week_int,
  CASE
  WHEN CAL.day_of_week IN (1, 2)
  THEN 1
  WHEN CAL.day_of_week IN (6, 7)
  THEN 3
  ELSE 2
  END AS adv_wt_nr_int,
 CAL.cy_week,
 adv.client_id,
 CO.country_iso_cd,
 WH.src_wh_id AS wh_id,
 TRIM('KW ' || TRIM(SUBSTR(CAST(MOD(CAST(CAL.cy_week AS BIGNUMERIC), 100) AS STRING), 1, 10)) || ' / ' || TRIM(SUBSTR(CAST(CASE
         WHEN CAL.day_of_week IN (1, 2)
         THEN 1
         WHEN CAL.day_of_week IN (6, 7)
         THEN 3
         ELSE 2
         END AS STRING), 1, 10)) || '  ' || TRIM(SUBSTR(CAST(CAL.cy AS STRING), 1, 39))) AS week_adv,
 adv.dat_adv
FROM (SELECT client_id,
    wh_loc_sid,
    dat_adv
   FROM ldl_p_lew_core_ac.v_wawi_adv_item_advertising_1 AS ADV
   UNION DISTINCT
   SELECT client_id,
    wh_loc_sid,
    dat_adv
   FROM ldl_p_lew_core_ac.v_wawi_adv_item_advertising_s_ap_1 AS ADV_S_AP) AS adv
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON adv.client_id = WH.client_id AND adv.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL ON adv.dat_adv = CAL.cal_dt
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_1 AS CO ON adv.client_id = CO.country_id
GROUP BY CAL.cy,
 adv_week_int,
 adv_wt_nr_int,
 CAL.cy_week,
 adv.client_id,
 CO.country_iso_cd,
 wh_id,
 week_adv,
 adv.dat_adv;
