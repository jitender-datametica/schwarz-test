CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_kpges_mth_country_1 AS
SELECT wh.client_id,
 wh.indicator_id,
 wh.cy_month,
  CASE
  WHEN wh.indicator_id = 117 AND wh.indicator_type_id = 1 AND wh.mig_fg = 0
  THEN CASE
   WHEN alt_mwst.mwst IS NOT NULL
   THEN wh.val_indicator / alt_mwst.mwst
   ELSE wh.val_indicator
   END
  WHEN wh.indicator_id = 117 AND wh.indicator_type_id = 1 AND wh.mig_fg = 1 AND wh.client_id = 1
  THEN 0
  WHEN wh.indicator_id = 338
  THEN (SELECT ROUND(SUM(SUBQRY.val_indicator) / COALESCE(CASE
        WHEN SUM(CASE
           WHEN SUBQRY.val_indicator <> 0
           THEN 1
           ELSE 0
           END) <> 0
        THEN SUM(CASE
          WHEN SUBQRY.val_indicator <> 0
          THEN 1
          ELSE 0
          END)
        ELSE 1
        END, 1), 2) AS val_indicator_val_indicator_val_indicator
   FROM ldl_p_lew_bil_ac.v_kpi_month_1 AS SUBQRY
    INNER JOIN ldl_p_lew_core_ac.v_cal_month_1 AS SUBMON ON SUBQRY.cy * 100 + SUBQRY.month_id = SUBMON.cy_month AND SUBMON
      .cy_month_seq BETWEEN MON.cy_month_seq - 11 AND MON.cy_month_seq
   WHERE wh.client_id = SUBQRY.client_id
    AND SUBQRY.indicator_id = 236
    AND SUBQRY.indicator_type_id = 1
    AND SUBQRY.org_type_id = 20)
  WHEN wh.indicator_id = 340
  THEN (SELECT ROUND(SUM(SUBQRY0.val_indicator), 2) AS val_indicator
   FROM ldl_p_lew_bil_ac.v_kpi_month_1 AS SUBQRY0
    INNER JOIN ldl_p_lew_core_ac.v_cal_month_1 AS SUBMON0 ON SUBQRY0.cy * 100 + SUBQRY0.month_id = SUBMON0.cy_month AND
      SUBMON0.cy_month_seq BETWEEN MON.cy_month_seq - 11 AND MON.cy_month_seq
   WHERE wh.client_id = SUBQRY0.client_id
    AND SUBQRY0.indicator_id = 191
    AND SUBQRY0.indicator_type_id = 1
    AND SUBQRY0.org_type_id = 20)
  WHEN wh.indicator_id = 341
  THEN (SELECT ROUND(SUM(SUBQRY1.val_indicator), 2) AS val_indicator
   FROM ldl_p_lew_bil_ac.v_kpi_month_1 AS SUBQRY1
    INNER JOIN ldl_p_lew_core_ac.v_cal_month_1 AS SUBMON1 ON SUBQRY1.cy * 100 + SUBQRY1.month_id = SUBMON1.cy_month AND
      SUBMON1.cy_month_seq BETWEEN MON.cy_month_seq - 11 AND MON.cy_month_seq
   WHERE wh.client_id = SUBQRY1.client_id
    AND SUBQRY1.indicator_id = 239
    AND SUBQRY1.indicator_type_id = 1
    AND SUBQRY1.org_type_id = 20)
  ELSE wh.val_indicator
  END AS val_indicator,
 wh.currency_iso_cd,
  CASE
  WHEN wh.indicator_id = 117 AND wh.indicator_type_id = 1 AND wh.mig_fg = 1 AND wh.client_id = 1
  THEN NULL
  ELSE wh.dat_dayend
  END AS dat_dayend
FROM (SELECT IMTH.client_id,
   IMTH.org_unit_nr AS wh_id,
    CASE
    WHEN IMTH.org_type_id = 50
    THEN 1
    ELSE 2
    END AS aspect_id,
   IMTH.indicator_id,
   IMTH.cy,
     IMTH.cy * 100 + IMTH.month_id AS cy_month,
    CASE
    WHEN IMTH.indicator_id IN (117, 120, 125, 126, 133, 135, 136, 155, 156, 157, 163, 168, 169, 170, 172, 174, 177, 179
      , 203, 204, 209, 210, 212, 216, 228, 229, 230, 238, 240, 242, 250, 251, 255, 256, 257, 258, 259, 260, 261, 270,
      271, 272, 273, 280, 281, 282, 283, 284, 286, 373, 374, 375, 376, 377)
    THEN IMTH.val_indicator / CRY.rate_currency_exchange
    ELSE IMTH.val_indicator
    END AS val_indicator,
   CRY.currency_iso_cd,
   IMTH.dat_dayend,
    CASE
    WHEN (IMTH.cy * 100 + IMTH.month_id) BETWEEN ROUND(CAST(FORMAT_DATE('%Y%m', MIG.migration_dat_valid_from) AS BIGNUMERIC)
      , 0) AND (ROUND(CAST(FORMAT_DATE('%Y%m', MIG.migration_dat_valid_to) AS BIGNUMERIC), 0))
    THEN 1
    ELSE 0
    END AS mig_fg,
   IMTH.indicator_type_id,
   CRY.to_currency_iso_cd,
   CRY.rate_currency_exchange,
   IMTH.val_indicator AS kpi_val_indicator
  FROM ldl_p_lew_bil_ac.v_kpi_month_1 AS IMTH
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON IMTH.client_id = CRY.client_id AND
     CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
   INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS MIG ON IMTH.client_id = MIG.client_id
  WHERE IMTH.indicator_type_id = 1
   AND IMTH.org_type_id = 20) AS wh
 LEFT JOIN (SELECT client_id,
   FORMAT_DATE('%Y%m', inv_end_date) AS cy_month,
    SUM(val_retail) / SUM(val_retail_net) AS mwst
  FROM ldl_p_lew_mart_msi.v_inv_wh_ejr_txj_ww_1 AS WW
  GROUP BY client_id,
   cy_month) AS alt_mwst ON CAST(alt_mwst.cy_month AS FLOAT64) = wh.cy_month AND wh.client_id = alt_mwst.client_id
 INNER JOIN ldl_p_lew_core_ac.v_cal_month_1 AS MON ON wh.cy_month = MON.cy_month;