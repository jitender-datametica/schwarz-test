CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_all_fk_forecast_quality_2 (country_2, source_flag, store, date, wh
, promotion, is_amount_zero, hour_last_sale, itemno, special_placement, v_model, forecast_day, source_extraction_tmsp,
snflk_insert_tmsp, snflk_update_tmsp, pfc, amount, `over`, under, d_pfc, forecast_no_ratio, pfc_rare_sales, pfc_hist,
filtered_fc, pfc_before_trend) AS WITH FC AS (SELECT country_2,
    source_flag,
    1 AS is_future,
    pfc,
    CAST(NULL AS BIGNUMERIC) AS forecast_no_ratio,
    CAST(NULL AS BIGNUMERIC) AS pfc_rare_sales,
    CAST(NULL AS BIGNUMERIC) AS pfc_before_trend,
    wh,
    store,
    DATE(date_) AS date,
    itemno,
    promotion,
    CAST(NULL AS BIGNUMERIC) AS special_placement,
    v_model,
    CAST(NULL AS BIGNUMERIC) AS is_trend,
    DATE_DIFF(CURRENT_DATE, DATE(forecast_date), DAY) AS forecast_day,
    'int' AS tab,
    source_extraction_tmsp,
    snflk_insert_tmsp,
    snflk_update_tmsp
   FROM ldl_autodispo_core.t_internal_forecast_results_2
   WHERE DATE(date_) >= CURRENT_DATE
   UNION ALL
   SELECT country_2,
    source_flag,
    0 AS is_future,
    pfc,
    CAST(NULL AS BIGNUMERIC) AS forecast_no_ratio,
    CAST(NULL AS BIGNUMERIC) AS pfc_rare_sales,
    CAST(NULL AS BIGNUMERIC) AS pfc_before_trend,
    wh,
    store,
    DATE(date_) AS date,
    itemno,
    promotion,
    CAST(NULL AS BIGNUMERIC) AS special_placement,
    v_model,
    CAST(NULL AS BIGNUMERIC) AS is_trend,
    forecast_day,
    'int' AS tab,
    source_extraction_tmsp,
    snflk_insert_tmsp,
    snflk_update_tmsp
   FROM ldl_autodispo_core.t_internal_forecast_results_2 AS INT
   WHERE DATE(date_) < CURRENT_DATE
   UNION ALL
   SELECT FRR.country_2,
    0 AS source_flag,
    1 AS is_future,
    FRR.pfc,
    FRR.pfc_model AS forecast_no_ratio,
    FRR.pfc_rare_sales,
    FRR.pfc_before_trend,
    FRR.wh,
    FRR.store,
    DATE(FRR.date_) AS date,
    FRR.itemno,
    FRR.promotion,
    FRR.spec_placement AS special_placement,
    FRR.v_model,
    FRR.is_trend,
    FD.forecast_day,
    'frr' AS tab,
    FRR.source_extraction_tmsp,
    FRR.snflk_insert_tmsp,
    FRR.snflk_update_tmsp
   FROM ldl_autodispo_core.t_hive_final_results_reduced_2 AS FRR
    INNER JOIN ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_forecast_day_2 AS FD ON FRR.country_2 = FD.country_2
   WHERE DATE(FRR.date_) >= CURRENT_DATE
   UNION ALL
   SELECT country_2,
    0 AS source_flag,
    0 AS is_future,
    pfc,
    pfc_model AS forecast_no_ratio,
    pfc_rare_sales,
    pfc_before_trend,
    ROUND(CAST(wh AS BIGNUMERIC), 0) AS wh,
    ROUND(CAST(store AS BIGNUMERIC), 0) AS store,
    DATE(date_) AS date,
    itemno,
    promotion,
    spec_placement AS special_placement,
    v_model,
    is_trend,
    forecast_day,
    'hfr' AS tab,
    source_extraction_tmsp,
    snflk_insert_tmsp,
    snflk_update_tmsp
   FROM ldl_autodispo_core.t_hive_hist_final_results_reduced_2 AS HFR
   WHERE DATE(date_) < CURRENT_DATE), SAL AS (SELECT FQR.country_2,
    0 AS source_flag,
    CAST(FQR.store AS BIGNUMERIC) AS store,
    FQR.wh,
    DATE(FQR.date_) AS date,
    FQR.itemno,
    FQR.amount,
     CASE
     WHEN FQR.amount = 0
     THEN 1
     ELSE 0
     END AS is_amount_zero,
    TIME(CAST(TRIM(FQR.sale_last_time_int) AS TIME)) AS hour_last_sale,
    FQR.promotion,
    FQR.special_placement,
    FQR.v_model,
    FQR.is_trend,
    FD.forecast_day,
    'fqr' AS tab,
    FQR.source_extraction_tmsp,
    FQR.snflk_insert_tmsp,
    FQR.snflk_update_tmsp
   FROM ldl_autodispo_core.t_hive_v_forecast_quality_reduced_2 AS FQR
    INNER JOIN ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_forecast_day_2 AS FD ON FQR.country_2 = FD.country_2
   WHERE FQR.forecast_day = 1
   UNION ALL
   SELECT S.country_2,
    1 AS source_flag,
    S.sales_store_nr AS store,
    ST.store_wh AS wh,
    DATE(S.date_) AS date,
    S.sales_item_nr AS itemno,
    S.sales_quantity AS amount,
     CASE
     WHEN S.sales_quantity = 0
     THEN 1
     ELSE 0
     END AS is_amount_zero,
    CAST(NULL AS TIME) AS hour_last_sale,
    CAST(NULL AS BIGNUMERIC) AS promotion,
    CAST(NULL AS BIGNUMERIC) AS special_placement,
    CAST(NULL AS STRING) AS v_model,
    CAST(NULL AS BIGNUMERIC) AS is_trend,
    FD.forecast_day,
    'ora' AS tab,
    S.source_extraction_tmsp,
    S.snflk_insert_tmsp,
    S.snflk_update_tmsp
   FROM ldl_autodispo_core.t_oracle_v_fk_sales_2 AS S
    INNER JOIN ldl_autodispo_core.t_oracle_v_dim_store_2 AS ST ON S.sales_store_nr = ST.store_nr AND S.country_2 = ST.country_2
        AND ST.deleted = 0
    INNER JOIN ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_forecast_day_2 AS FD ON S.country_2 = FD.country_2
   WHERE S.deleted = 0) (SELECT f.country_2,
   f.source_flag,
   f.store,
   DATE(f.date) AS date,
   f.wh,
   f.promotion,
   IFNULL(s.is_amount_zero, 0),
   s.hour_last_sale,
   f.itemno,
   f.special_placement,
   f.v_model,
   f.forecast_day,
   f.source_extraction_tmsp,
   f.snflk_insert_tmsp,
   f.snflk_update_tmsp,
   f.pfc,
   s.amount,
   GREATEST(0, f.pfc - s.amount) AS `over`,
   LEAST(0, f.pfc - s.amount) AS under,
    CASE
    WHEN f.date < CURRENT_DATE
    THEN ABS(IFNULL(f.pfc, 0) - IFNULL(s.amount, 0))
    ELSE NULL
    END AS d_pfc,
   0 AS forecast_no_ratio,
   f.pfc_rare_sales,
    CASE
    WHEN f.date < CURRENT_DATE
    THEN f.pfc
    ELSE NULL
    END AS pfc_hist,
    CASE
    WHEN s.amount <> 0 AND f.date < CURRENT_DATE
    THEN f.pfc
    ELSE NULL
    END AS filtered_fc,
   f.pfc_before_trend
  FROM FC AS f
   LEFT JOIN SAL AS s ON f.country_2 = s.country_2 AND f.itemno = s.itemno AND CAST(f.store AS BIGNUMERIC) = ROUND(CAST(s.store AS BIGNUMERIC)
         , 0) AND f.forecast_day = s.forecast_day AND DATE(f.date) = DATE(s.date) AND f.source_flag = s.source_flag);