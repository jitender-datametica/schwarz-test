CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_kpges_week_to_mth_int_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT IW.indicator_id,
 cw.cy_month,
 SUM(IW.val_indicator) OVER (PARTITION BY CAST(IW.indicator_id AS STRING), CAST(cw.cy_month AS STRING), CAST(cw.cy_week AS STRING)
    , IW.dat_dayend RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS val_indicator,
 SUM(IW.val_indicator) OVER (PARTITION BY CAST(IW.indicator_id AS STRING), CAST(cw.cy_month AS STRING), IW.dat_dayend
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS val_indicator_sum_all,
 COUNT(cw.cy_week) OVER (PARTITION BY CAST(IW.client_id AS STRING), CAST(IW.indicator_id AS STRING), CAST(cw.cy_month AS STRING)
    , IW.dat_dayend RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS count_weeks,
 IW.dat_dayend
FROM ldl_p_lew_core_ac.v_wawi_indicator_week_2 AS IW
 INNER JOIN (SELECT cy_month,
   cy_week
  FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday_2
  WHERE (cy_month, cy_week) NOT IN (SELECT (CMTH.prev_month, MIN(CDAY.cy_week))
     FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday_2 AS CDAY
      INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_month_2 AS CMTH ON CDAY.cy_month = CMTH.cy_month
     GROUP BY CMTH.prev_month)
  GROUP BY cy_week,
   cy_month) AS cw ON IW.cy * 100 + IW.cal_week = cw.cy_week AND IW.org_type_id = 10 AND IW.indicator_type_id = 1
QUALIFY cw.cy_week = (MAX(cw.cy_week) OVER (PARTITION BY CAST(IW.client_id AS STRING), CAST(IW.indicator_id AS STRING), CAST(cw.cy_month AS STRING)
      , IW.dat_dayend RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING));