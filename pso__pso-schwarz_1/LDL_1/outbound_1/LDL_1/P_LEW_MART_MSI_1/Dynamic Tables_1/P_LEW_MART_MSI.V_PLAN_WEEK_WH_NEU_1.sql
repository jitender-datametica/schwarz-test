CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_plan_week_wh_neu_1 AS
-- zu verwenden für die Berechnung aufgelaufener Werte. Siehe OP 160788.
 SELECT PM.plan_id,
 PM.indicator_id,
 PM.client_id,
 VLMK.wawi_dwh_wh_id AS wh_id,
 PM.cy_week,
  CASE
  WHEN PM.indicator_id IN (200, 201, 202, 607, 700, 900)
  THEN PM.val_plan_week
  ELSE PM.val_plan_week / CRY.rate_currency_exchange
  END AS val_plan,
 PM.pct_plan_week AS pct_plan,
 PM.dat_dayend,
 CRY.currency_iso_cd,
 PM.dat_valid_from,
 PM.dat_valid_until,
 CAL.busyear,
 SUM(CASE
   WHEN PM.indicator_id IN (200, 201, 202, 607, 700, 900)
   THEN PM.val_plan_week
   ELSE PM.val_plan_week / CRY.rate_currency_exchange
   END) OVER (PARTITION BY CAST(PM.plan_id AS STRING), CAST(PM.indicator_id AS STRING), CAST(PM.client_id AS STRING), CAST(PM.wh_loc_sid AS STRING)
    , CRY.currency_iso_cd, CAST(CAL.busyear AS STRING) ORDER BY PM.dat_valid_from IS NULL, PM.dat_valid_from
  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS val_plan_cum1,
 RANK() OVER (PARTITION BY CAST(PM.plan_id AS STRING), CAST(PM.indicator_id AS STRING), CAST(PM.client_id AS STRING), CAST(PM.wh_loc_sid AS STRING)
    , CAST(PM.cy_week AS STRING), CRY.currency_iso_cd ORDER BY CAL.busyear IS NULL, CAL.busyear) AS val_plan_cum_rank,
  CASE
  WHEN (RANK() OVER (PARTITION BY CAST(PM.plan_id AS STRING), CAST(PM.indicator_id AS STRING), CAST(PM.client_id AS STRING)
       , CAST(PM.wh_loc_sid AS STRING), CAST(PM.cy_week AS STRING), CRY.currency_iso_cd ORDER BY CAL.busyear IS NULL,
       CAL.busyear)) = 1
  THEN SUM(CASE
    WHEN PM.indicator_id IN (200, 201, 202, 607, 700, 900)
    THEN PM.val_plan_week
    ELSE PM.val_plan_week / CRY.rate_currency_exchange
    END) OVER (PARTITION BY CAST(PM.plan_id AS STRING), CAST(PM.indicator_id AS STRING), CAST(PM.client_id AS STRING), CAST(PM.wh_loc_sid AS STRING)
     , CRY.currency_iso_cd, CAST(CAL.busyear AS STRING) ORDER BY PM.dat_valid_from IS NULL, PM.dat_valid_from
   ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
  ELSE NULL
  END AS val_plan_cum,
  CASE
  WHEN (RANK() OVER (PARTITION BY CAST(PM.plan_id AS STRING), CAST(PM.indicator_id AS STRING), CAST(PM.client_id AS STRING)
       , CAST(PM.wh_loc_sid AS STRING), CAST(PM.cy_week AS STRING), CRY.currency_iso_cd ORDER BY CAL.busyear IS NULL,
       CAL.busyear)) = 1
  THEN CASE
   WHEN PM.indicator_id IN (200, 201, 202, 607, 700, 900)
   THEN PM.val_plan_week
   ELSE PM.val_plan_week / CRY.rate_currency_exchange
   END
  ELSE NULL
  END AS val_plan1
FROM ldl_p_lew_core_ac.v_wawi_plan_week_1 AS PM_1
 INNER JOIN ldl_p_lew_core_ac.v_loc_map_key_1 AS VLMK ON PM.wh_loc_sid = VLMK.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_calendarday_1 AS CAL ON PM.dat_valid_from = CAL.dat_calendar
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON PM.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
WHERE PM.wh_loc_sid IS NOT NULL
 AND PM.orig_store_nr IS NULL
 AND CAL.cy_day_sequence <= 0;