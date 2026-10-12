
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_inv_top_20_cum_2
AS
SELECT act.country_id,
 act.cy_month,
 act.wh_id,
 act.client_id,
 act.byr,
 act.store_id,
  act.diff_inv_cum / CRY.rate_currency_exchange AS diff_inv_cum,
  act.diff_net_inv_cum / CRY.rate_currency_exchange AS diff_net_inv_cum,
  act.ums_cum / CRY.rate_currency_exchange AS ums_cum,
  act.ums_net_cum / CRY.rate_currency_exchange AS ums_net_cum,
  py.diff_inv_cum / CRY.rate_currency_exchange AS diff_inv_cum_py,
  py.diff_net_inv_cum / CRY.rate_currency_exchange AS diff_net_inv_cum_py,
  py.ums_cum / CRY.rate_currency_exchange AS ums_cum_py,
  py.ums_net_cum / CRY.rate_currency_exchange AS ums_net_cum_py,
 act.diff_inv_ums_pct,
 act.diff_net_inv_ums_pct,
 CRY.currency_iso_cd,
 ROW_NUMBER() OVER (PARTITION BY CAST(act.client_id AS STRING), CAST(act.cy_month AS STRING), CAST(act.wh_id AS STRING)
    , CRY.currency_iso_cd ORDER BY act.diff_inv_ums_pct IS NULL, act.diff_inv_ums_pct, act.diff_inv_cum IS NULL, act.diff_inv_cum
    ) AS rank_wh_pct,
 ROW_NUMBER() OVER (PARTITION BY CAST(act.client_id AS STRING), CAST(act.cy_month AS STRING), CRY.currency_iso_cd
  ORDER BY act.diff_inv_ums_pct IS NULL, act.diff_inv_ums_pct, act.diff_inv_cum IS NULL, act.diff_inv_cum) AS
 rank_client_pct
FROM (SELECT A12.client_id AS country_id,
   A13.cy_month,
   A12.wh_id,
   A12.client_id,
   A13.byr,
   A12.store_id,
   A12.client_id AS client_id0,
   SUM(SUM(a11.diff_inv)) OVER (PARTITION BY CAST(A12.client_id AS STRING), CAST(A13.byr AS STRING), CAST(A12.store_id AS STRING)
      , CAST(A12.client_id AS STRING) ORDER BY A13.cy_month IS NULL, A13.cy_month ROWS BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW) AS diff_inv_cum,
   SUM(SUM(a11.diff_net_inv)) OVER (PARTITION BY CAST(A12.client_id AS STRING), CAST(A13.byr AS STRING), CAST(A12.store_id AS STRING)
      , CAST(A12.client_id AS STRING) ORDER BY A13.cy_month IS NULL, A13.cy_month ROWS BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW) AS diff_net_inv_cum,
   SUM(SUM(a11.val_retail_store_inv_stc)) OVER (PARTITION BY CAST(A12.client_id AS STRING), CAST(A13.byr AS STRING), CAST(A12.store_id AS STRING)
      , CAST(A12.client_id AS STRING) ORDER BY A13.cy_month IS NULL, A13.cy_month ROWS BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW) AS ums_cum,
   SUM(SUM(a11.val_retail_store_net_inv_stc)) OVER (PARTITION BY CAST(A12.client_id AS STRING), CAST(A13.byr AS STRING)
      , CAST(A12.store_id AS STRING), CAST(A12.client_id AS STRING) ORDER BY A13.cy_month IS NULL, A13.cy_month
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ums_net_cum,
    CAST(COALESCE(SUM(SUM(a11.diff_inv)) OVER (PARTITION BY CAST(A12.client_id AS STRING), CAST(A13.byr AS STRING), CAST(A12.store_id AS STRING)
         , CAST(A12.client_id AS STRING) ORDER BY A13.cy_month IS NULL, A13.cy_month ROWS BETWEEN UNBOUNDED PRECEDING
       AND CURRENT ROW), 0) AS NUMERIC) / CASE
     WHEN (SUM(SUM(a11.val_retail_store_inv_stc)) OVER (PARTITION BY CAST(A12.client_id AS STRING), CAST(A13.byr AS STRING)
          , CAST(A12.store_id AS STRING), CAST(A12.client_id AS STRING) ORDER BY A13.cy_month IS NULL, A13.cy_month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
     THEN NULL
     ELSE SUM(SUM(a11.val_retail_store_inv_stc)) OVER (PARTITION BY CAST(A12.client_id AS STRING), CAST(A13.byr AS STRING)
        , CAST(A12.store_id AS STRING), CAST(A12.client_id AS STRING) ORDER BY A13.cy_month IS NULL, A13.cy_month
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
     END AS diff_inv_ums_pct,
    CAST(COALESCE(SUM(SUM(a11.diff_net_inv)) OVER (PARTITION BY CAST(A12.client_id AS STRING), CAST(A13.byr AS STRING), CAST(A12.store_id AS STRING)
         , CAST(A12.client_id AS STRING) ORDER BY A13.cy_month IS NULL, A13.cy_month ROWS BETWEEN UNBOUNDED PRECEDING
       AND CURRENT ROW), 0) AS NUMERIC) / CASE
     WHEN (SUM(SUM(a11.val_retail_store_net_inv_stc)) OVER (PARTITION BY CAST(A12.client_id AS STRING), CAST(A13.byr AS STRING)
          , CAST(A12.store_id AS STRING), CAST(A12.client_id AS STRING) ORDER BY A13.cy_month IS NULL, A13.cy_month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
     THEN NULL
     ELSE SUM(SUM(a11.val_retail_store_net_inv_stc)) OVER (PARTITION BY CAST(A12.client_id AS STRING), CAST(A13.byr AS STRING)
        , CAST(A12.store_id AS STRING), CAST(A12.client_id AS STRING) ORDER BY A13.cy_month IS NULL, A13.cy_month
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
     END AS diff_net_inv_ums_pct
  FROM ldl_p_lew_mart_msi.v_org_store_skey_2 AS A12
   INNER JOIN ldl_p_lew_mart_msi.v_cal_month_2 AS A13 ON TRUE
   LEFT JOIN (SELECT client_id,
     st_loc_sid AS store_id,
     diff_inv,
     diff_net_inv,
     val_retail_store_inv_stc,
     val_retail_store_net_inv_stc,
     dat_valid_until
    FROM ldl_p_lew_core_ac.v_wawi_inv_store_2
    WHERE inv_fg = 71
     AND status_inv_sic = 64) AS a11 ON A12.client_id = a11.client_id AND A12.store_id = a11.store_id AND EXTRACT(YEAR
        FROM a11.dat_valid_until) * 100 + EXTRACT(MONTH FROM a11.dat_valid_until) = A13.cy_month
   INNER JOIN ldl_p_lew_mart_msi.v_cal_busyear_2 AS A14 ON A13.byr = A14.byr
  WHERE A14.cy_by_sequence BETWEEN - 1 AND 0
   AND A13.cy_month_sequence <= 0
  GROUP BY a11.client_id,
   A13.cy_month,
   A12.wh_id,
   client_id0,
   A13.byr,
   A12.store_id) AS act
 LEFT JOIN (SELECT A120.client_id AS country_id,
   A130.cy_month,
   A120.wh_id,
   A120.client_id,
   A130.byr,
   A120.store_id,
   A120.client_id AS client_id0,
   SUM(SUM(a11.diff_inv)) OVER (PARTITION BY CAST(A120.client_id AS STRING), CAST(A130.byr AS STRING), CAST(A120.store_id AS STRING)
      , CAST(A120.client_id AS STRING) ORDER BY A130.cy_month IS NULL, A130.cy_month ROWS BETWEEN UNBOUNDED PRECEDING
    AND CURRENT ROW) AS diff_inv_cum,
   SUM(SUM(a11.diff_net_inv)) OVER (PARTITION BY CAST(A120.client_id AS STRING), CAST(A130.byr AS STRING), CAST(A120.store_id AS STRING)
      , CAST(A120.client_id AS STRING) ORDER BY A130.cy_month IS NULL, A130.cy_month ROWS BETWEEN UNBOUNDED PRECEDING
    AND CURRENT ROW) AS diff_net_inv_cum,
   SUM(SUM(a11.val_retail_store_inv_stc)) OVER (PARTITION BY CAST(A120.client_id AS STRING), CAST(A130.byr AS STRING), CAST(A120.store_id AS STRING)
      , CAST(A120.client_id AS STRING) ORDER BY A130.cy_month IS NULL, A130.cy_month ROWS BETWEEN UNBOUNDED PRECEDING
    AND CURRENT ROW) AS ums_cum,
   SUM(SUM(a11.val_retail_store_net_inv_stc)) OVER (PARTITION BY CAST(A120.client_id AS STRING), CAST(A130.byr AS STRING)
      , CAST(A120.store_id AS STRING), CAST(A120.client_id AS STRING) ORDER BY A130.cy_month IS NULL, A130.cy_month
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ums_net_cum,
    CAST(COALESCE(SUM(SUM(a11.diff_inv)) OVER (PARTITION BY CAST(A120.client_id AS STRING), CAST(A130.byr AS STRING), CAST(A120.store_id AS STRING)
         , CAST(A120.client_id AS STRING) ORDER BY A130.cy_month IS NULL, A130.cy_month ROWS BETWEEN UNBOUNDED PRECEDING
       AND CURRENT ROW), 0) AS NUMERIC) / CASE
     WHEN (SUM(SUM(a11.val_retail_store_inv_stc)) OVER (PARTITION BY CAST(A120.client_id AS STRING), CAST(A130.byr AS STRING)
          , CAST(A120.store_id AS STRING), CAST(A120.client_id AS STRING) ORDER BY A130.cy_month IS NULL, A130.cy_month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
     THEN NULL
     ELSE SUM(SUM(a11.val_retail_store_inv_stc)) OVER (PARTITION BY CAST(A120.client_id AS STRING), CAST(A130.byr AS STRING)
        , CAST(A120.store_id AS STRING), CAST(A120.client_id AS STRING) ORDER BY A130.cy_month IS NULL, A130.cy_month
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
     END AS diff_inv_ums_pct,
    CAST(COALESCE(SUM(SUM(a11.diff_net_inv)) OVER (PARTITION BY CAST(A120.client_id AS STRING), CAST(A130.byr AS STRING)
         , CAST(A120.store_id AS STRING), CAST(A120.client_id AS STRING) ORDER BY A130.cy_month IS NULL, A130.cy_month
       ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 0) AS NUMERIC) / CASE
     WHEN (SUM(SUM(a11.val_retail_store_net_inv_stc)) OVER (PARTITION BY CAST(A120.client_id AS STRING), CAST(A130.byr AS STRING)
          , CAST(A120.store_id AS STRING), CAST(A120.client_id AS STRING) ORDER BY A130.cy_month IS NULL, A130.cy_month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
     THEN NULL
     ELSE SUM(SUM(a11.val_retail_store_net_inv_stc)) OVER (PARTITION BY CAST(A120.client_id AS STRING), CAST(A130.byr AS STRING)
        , CAST(A120.store_id AS STRING), CAST(A120.client_id AS STRING) ORDER BY A130.cy_month IS NULL, A130.cy_month
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
     END AS diff_net_inv_ums_pct
  FROM ldl_p_lew_mart_msi.v_org_store_skey_2 AS A120
   INNER JOIN ldl_p_lew_mart_msi.v_cal_month_2 AS A130 ON TRUE
   INNER JOIN (SELECT dat_calendar
    FROM ldl_p_lew_mart_msi.v_cal_calendarday_2
    WHERE cy_day_sequence = 0) AS act_day ON TRUE
   LEFT JOIN (SELECT client_id,
     st_loc_sid AS store_id,
     diff_inv,
     diff_net_inv,
     val_retail_store_inv_stc,
     val_retail_store_net_inv_stc,
     dat_valid_until
    FROM ldl_p_lew_core_ac.v_wawi_inv_store_2
    WHERE inv_fg = 71
     AND status_inv_sic = 64) AS a11 ON A120.client_id = a11.client_id AND A120.store_id = a11.store_id AND EXTRACT(YEAR
         FROM a11.dat_valid_until) * 100 + EXTRACT(MONTH FROM a11.dat_valid_until) = A130.prev_cy_month AND CASE
      WHEN A130.cy_month_sequence = 0
      THEN CAST(EXTRACT(DAY FROM a11.dat_valid_until) AS INTEGER)
      ELSE 0
      END <= EXTRACT(DAY FROM act_day.dat_calendar)
   INNER JOIN ldl_p_lew_mart_msi.v_cal_busyear_2 AS A140 ON A130.byr = A140.byr
  WHERE A140.cy_by_sequence BETWEEN - 1 AND 0
   AND A130.cy_month_sequence <= 0
  GROUP BY a11.client_id,
   A130.cy_month,
   A120.wh_id,
   client_id0,
   A130.byr,
   A120.store_id) AS py ON act.client_id = py.client_id AND act.cy_month = py.cy_month AND act.wh_id = py.wh_id AND act
    .byr = py.byr AND act.store_id = py.store_id
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON act.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
WHERE act.diff_inv_cum IS NOT NULL
 OR py.diff_inv_cum IS NOT NULL AND CRY.rate_currency_exchange IS NOT NULL;

