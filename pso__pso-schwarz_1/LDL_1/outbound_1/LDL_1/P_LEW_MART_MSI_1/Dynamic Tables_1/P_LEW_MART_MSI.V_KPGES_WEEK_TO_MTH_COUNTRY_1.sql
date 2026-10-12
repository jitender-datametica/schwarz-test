CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_kpges_week_to_mth_country_1 AS
SELECT IW.client_id,
 IW.indicator_id,
 cw.cy_month,
 SUM(CASE
   WHEN IW.indicator_id IN (117, 120, 125, 126, 133, 135, 136, 155, 156, 157, 163, 168, 169, 170, 172, 174, 177, 179,
     203, 204, 209, 210, 212, 216, 228, 229, 230, 238, 240, 242, 250, 251, 255, 256, 257, 258, 259, 260, 261, 270, 271,
     272, 273, 280, 281, 282, 283, 284, 286)
   THEN IW.val_indicator / CRY.rate_currency_exchange
   ELSE IW.val_indicator
   END) AS val_indicator,
 SUM(SUM(CASE
    WHEN IW.indicator_id IN (117, 120, 125, 126, 133, 135, 136, 155, 156, 157, 163, 168, 169, 170, 172, 174, 177, 179,
      203, 204, 209, 210, 212, 216, 228, 229, 230, 238, 240, 242, 250, 251, 255, 256, 257, 258, 259, 260, 261, 270, 271
      , 272, 273, 280, 281, 282, 283, 284, 286)
    THEN IW.val_indicator / CRY.rate_currency_exchange
    ELSE IW.val_indicator
    END)) OVER (PARTITION BY CAST(IW.client_id AS STRING), CAST(IW.indicator_id AS STRING), CAST(cw.cy_month AS STRING)
    , CRY.currency_iso_cd, IW.dat_dayend RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 val_indicator_sum_all,
 COUNT(cw.cy_week) OVER (PARTITION BY CAST(IW.client_id AS STRING), CAST(IW.indicator_id AS STRING), CAST(cw.cy_month AS STRING)
    , CRY.currency_iso_cd, IW.dat_dayend RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS count_weeks,
 CRY.currency_iso_cd,
 IW.dat_dayend
FROM ldl_p_lew_core_ac.v_wawi_indicator_week_1 AS IW
 INNER JOIN (SELECT cy_month,
   cy_week
  FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday_1
  WHERE (cy_month, cy_week) NOT IN (SELECT (CMTH.prev_month, MIN(CDAY.cy_week))
     FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday_1 AS CDAY
      INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_month_1 AS CMTH ON CDAY.cy_month = CMTH.cy_month
     GROUP BY CMTH.prev_month)
  GROUP BY cy_week,
   cy_month) AS cw ON IW.cy * 100 + IW.cal_week = cw.cy_week AND IW.org_type_id = 20 AND IW.indicator_type_id = 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON IW.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
GROUP BY IW.client_id,
 IW.indicator_id,
 cw.cy_month,
 cw.cy_week,
 CRY.currency_iso_cd,
 IW.dat_dayend
QUALIFY cw.cy_week = (MAX(cw.cy_week) OVER (PARTITION BY CAST(IW.client_id AS STRING), CAST(IW.indicator_id AS STRING), CAST(cw.cy_month AS STRING)
      , CRY.currency_iso_cd, IW.dat_dayend RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING));
