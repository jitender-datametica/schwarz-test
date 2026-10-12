CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_agg_promotion_sales_daily_no_gc_lc AS WITH CTE_PSD AS (SELECT
    wshop_cd,
    promo_id,
    prod_variant_sid,
    cust_order_dt,
    promo_start_dt,
    promo_sale_start_dt,
    is_special_analysis_fg,
    curr_cd,
    prod_price_net_local_val,
    cogs_price_net_local_val,
    prod_qty,
    cancel_prod_price_net_local_val,
    cancel_prod_qty,
    return_prod_price_net_local_val,
    return_prod_qty,
    total_prod_price_net_local_val,
    total_prod_qty,
    promo_sale_cluster_cd,
    prod_price_gross_local_val,
    cancel_prod_price_gross_local_val,
    return_prod_price_gross_local_val,
    total_prod_price_gross_local_val,
    prod_variant_nr,
    prod_orderable_lvl_cd,
    0 AS is_after_cancellation_fg
   FROM ldl_dig_lec_share.v_agg_promotion_sales_daily
   UNION ALL
   SELECT wshop_cd,
    promo_id,
    prod_variant_sid,
    cust_order_dt,
    promo_start_dt,
    promo_sale_start_dt,
    is_special_analysis_fg,
    curr_cd,
     prod_price_net_local_val - cancel_prod_price_net_local_val AS prod_price_net_local_val,
     cogs_price_net_local_val - cogs_price_net_local_val / IF(prod_qty = 0, NULL, prod_qty) * cancel_prod_qty AS
    cogs_price_net_local_val,
     prod_qty - cancel_prod_qty AS prod_qty,
    cancel_prod_price_net_local_val,
    cancel_prod_qty,
    return_prod_price_net_local_val,
    return_prod_qty,
    total_prod_price_net_local_val,
    total_prod_qty,
    promo_sale_cluster_cd,
     prod_price_gross_local_val - cancel_prod_price_gross_local_val AS prod_price_gross_local_val,
    cancel_prod_price_gross_local_val,
    return_prod_price_gross_local_val,
    total_prod_price_gross_local_val,
    prod_variant_nr,
    prod_orderable_lvl_cd,
    1 AS is_after_cancellation_fg
   FROM ldl_dig_lec_share.v_agg_promotion_sales_daily), CTE_PPC AS (SELECT IFNULL(FACT_PPC.prod_variant_sid, -1) AS
   prod_variant_sid,
    CASE
    WHEN FACT_PPC.wshop_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_PPC.wshop_cd, '-1')
    END AS wshop_cd,
    CASE
    WHEN FACT_PPC.price_type_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_PPC.price_type_cd, '-1')
    END AS price_type_cd,
    CASE
    WHEN FACT_PPC.price_group_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_PPC.price_group_cd, '-1')
    END AS price_group_cd,
   FACT_PPC.active_from_tmsp,
   FACT_PPC.active_to_tmsp,
    CASE
    WHEN FACT_PPC.curr_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_PPC.curr_cd, '-1')
    END AS curr_cd,
    FACT_PPC.price_val / CER_FACT0.exchange_rate AS price_eur_val,
   FACT_PPC.price_val AS price_local_val,
    CASE
    WHEN FACT_PPC.price_change_reason_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_PPC.price_change_reason_cd, '-1')
    END AS price_change_reason_cd
  FROM ldl_dig_lec_share.v_fact_product_pricing_condition AS FACT_PPC
   INNER JOIN ldl_dig_lec_share.v_fact_currency_exchange_rate AS CER_FACT0 ON FACT_PPC.curr_cd = CER_FACT0.from_curr_cd
    AND DATE(FACT_PPC.active_from_tmsp) BETWEEN CER_FACT0.active_from_dt AND CER_FACT0.active_to_dt
   INNER JOIN ldl_dig_lec_share.v_dim_currency_exchange_rate_type AS CERT_DIM0 ON CER_FACT0.curr_exchange_rate_type_cd =
     CERT_DIM0.curr_exchange_rate_type_cd AND CERT_DIM0.is_general_used_fg
  WHERE CER_FACT0.to_curr_cd = 'EUR'), CTE_PPS AS (SELECT IFNULL(FACT_PPS.prod_variant_sid, -1) AS prod_variant_sid,
    CASE
    WHEN FACT_PPS.wshop_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_PPS.wshop_cd, '-1')
    END AS wshop_cd,
    CASE
    WHEN FACT_PPS.price_type_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_PPS.price_type_cd, '-1')
    END AS price_type_cd,
    CASE
    WHEN FACT_PPS.price_group_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_PPS.price_group_cd, '-1')
    END AS price_group_cd,
   FACT_PPS.active_from_tmsp,
   FACT_PPS.active_to_tmsp,
    CASE
    WHEN WC_REL.curr_cd = ''
    THEN '-1'
    ELSE IFNULL(WC_REL.curr_cd, '-1')
    END AS curr_cd,
    FACT_PPS.price_val * CER_FACT2.exchange_rate AS price_local_val,
   FACT_PPS.price_val AS price_eur_val
  FROM ldl_dig_lec_share.v_fact_product_price_supplier AS FACT_PPS
   INNER JOIN ldl_dig_lec_share.v_dim_product_variant AS PV_DIM ON FACT_PPS.prod_variant_sid = PV_DIM.prod_variant_sid
     AND FACT_PPS.supplier_sid = PV_DIM.main_supplier_sid AND PV_DIM.dwh_valid_fg
   INNER JOIN ldl_dig_lec_share.v_rel_webshop_currency AS WC_REL ON FACT_PPS.wshop_cd = WC_REL.wshop_cd AND WC_REL.dwh_valid_fg
    
   INNER JOIN ldl_dig_lec_share.v_fact_currency_exchange_rate AS CER_FACT2 ON WC_REL.curr_cd = CER_FACT2.from_curr_cd
    AND DATE(FACT_PPS.active_from_tmsp) BETWEEN CER_FACT2.active_from_dt AND CER_FACT2.active_to_dt
   INNER JOIN ldl_dig_lec_share.v_dim_currency_exchange_rate_type AS CERT_DIM2 ON CER_FACT2.curr_exchange_rate_type_cd =
     CERT_DIM2.curr_exchange_rate_type_cd AND CERT_DIM2.is_general_used_fg
  WHERE CER_FACT2.to_curr_cd = 'EUR') (-- new field
 -- new field

  -- the field IS_SPECIAL_ANALYSIS_FG (a boolean) currently contains many nulls, which can not be fixed quickly in ETL. we use this field in MSTR instead so that joining on this field is possible.

  -- MSTR divides by this number, so it should not be zero

  -- if the AKP is set for this product/wshop, use the AKP. if it is not set, use the VKP.

  -- remove this section once MSTR has been remapped to use fields without AKP in the name
 -- end section
 -- add EKP

  -- end section
 -- they could be deleted if not used from this view

  -- they could be deleted if not used from this view
 -- new field
 -- new field
 SELECT CASE
    WHEN AGG_PSD.wshop_cd = ''
    THEN '-1'
    ELSE IFNULL(AGG_PSD.wshop_cd, '-1')
    END AS wshop_cd,
   IFNULL(AGG_PSD.promo_id, -1) AS promo_id,
   IFNULL(AGG_PSD.prod_variant_sid, -1) AS prod_variant_sid,
   AGG_PSD.cust_order_dt,
   AGG_PSD.promo_start_dt,
   AGG_PSD.promo_sale_start_dt,
   AGG_PSD.is_special_analysis_fg,
    CASE
    WHEN AGG_PSD.is_special_analysis_fg
    THEN '1'
    WHEN NOT AGG_PSD.is_special_analysis_fg
    THEN '0'
    ELSE '-1'
    END AS is_special_analysis_cd,
    CASE
    WHEN AGG_PSD.curr_cd = ''
    THEN '-1'
    ELSE IFNULL(AGG_PSD.curr_cd, '-1')
    END AS curr_cd,
    AGG_PSD.prod_price_net_local_val / CER_FACT.exchange_rate AS prod_price_net_eur_val,
   AGG_PSD.prod_price_net_local_val,
    AGG_PSD.cogs_price_net_local_val / CER_FACT.exchange_rate AS cogs_price_net_eur_val,
   AGG_PSD.cogs_price_net_local_val,
   IF(AGG_PSD.prod_qty = 0, NULL, AGG_PSD.prod_qty) AS prod_qty,
    AGG_PSD.cancel_prod_price_net_local_val / CER_FACT.exchange_rate AS cancel_prod_price_net_eur_val,
   AGG_PSD.cancel_prod_price_net_local_val,
   AGG_PSD.cancel_prod_qty,
    AGG_PSD.return_prod_price_net_local_val / CER_FACT.exchange_rate AS return_prod_price_net_eur_val,
   AGG_PSD.return_prod_price_net_local_val,
   AGG_PSD.return_prod_qty,
    AGG_PSD.total_prod_price_net_local_val / CER_FACT.exchange_rate AS total_prod_price_net_eur_val,
   AGG_PSD.total_prod_price_net_local_val,
   AGG_PSD.total_prod_qty,
    AGG_PSD.prod_price_gross_local_val / CER_FACT.exchange_rate AS prod_price_gross_eur_val,
   AGG_PSD.prod_price_gross_local_val,
    AGG_PSD.cancel_prod_price_gross_local_val / CER_FACT.exchange_rate AS cancel_prod_price_gross_eur_val,
   AGG_PSD.cancel_prod_price_gross_local_val,
    AGG_PSD.return_prod_price_gross_local_val / CER_FACT.exchange_rate AS return_prod_price_gross_eur_val,
   AGG_PSD.return_prod_price_gross_local_val,
    AGG_PSD.total_prod_price_gross_local_val / CER_FACT.exchange_rate AS total_prod_price_gross_eur_val,
   AGG_PSD.total_prod_price_gross_local_val,
   IFNULL(AGG_PSD.promo_sale_cluster_cd, -1) AS promo_sale_cluster_cd,
   IFNULL(MAX(AGG_PSD.promo_sale_cluster_cd) OVER (PARTITION BY AGG_PSD.wshop_cd, AGG_PSD.promo_start_dt, CAST(DIM_PV.prod_sid AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), -1) AS max_sales_cluster_cd,
   AGG_PSD.prod_variant_nr,
   AGG_PSD.is_after_cancellation_fg,
   COALESCE(FACT_PPC_AKP.price_type_cd, FACT_PPC_VKP.price_type_cd) AS price_type_cd,
   COALESCE(FACT_PPC_AKP.price_group_cd, FACT_PPC_VKP.price_group_cd) AS price_group_cd,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_PPC_AKP.active_from_tmsp, FACT_PPC_VKP.active_from_tmsp) AS TIMESTAMP)
      , 'Europe/Berlin')) AS DATETIME) AS ppc_active_from_tmsp,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_PPC_AKP.active_to_tmsp, FACT_PPC_VKP.active_to_tmsp) AS TIMESTAMP)
      , 'Europe/Berlin')) AS DATETIME) AS ppc_active_to_tmsp,
   COALESCE(FACT_PPC_AKP.curr_cd, FACT_PPC_VKP.curr_cd) AS ppc_curr_cd,
   COALESCE(FACT_PPC_AKP.price_eur_val, FACT_PPC_VKP.price_eur_val) AS ppc_price_eur_val,
   COALESCE(FACT_PPC_AKP.price_local_val, FACT_PPC_VKP.price_local_val) AS ppc_price_local_val,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_PPC_AKP.active_from_tmsp, FACT_PPC_VKP.active_from_tmsp) AS TIMESTAMP)
      , 'Europe/Berlin')) AS DATETIME) AS akp_active_from_tmsp,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_PPC_AKP.active_to_tmsp, FACT_PPC_VKP.active_to_tmsp) AS TIMESTAMP)
      , 'Europe/Berlin')) AS DATETIME) AS akp_active_to_tmsp,
   COALESCE(FACT_PPC_AKP.curr_cd, FACT_PPC_VKP.curr_cd) AS akp_curr_cd,
   COALESCE(FACT_PPC_AKP.price_eur_val, FACT_PPC_VKP.price_eur_val) AS akp_price_eur_val,
   COALESCE(FACT_PPC_AKP.price_local_val, FACT_PPC_VKP.price_local_val) AS akp_price_local_val,
   COALESCE(FACT_PPC_AKP.price_change_reason_cd, FACT_PPC_VKP.price_change_reason_cd) AS price_change_reason_cd,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_PPS_EKP.active_from_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME) AS ekp_active_from_tmsp,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_PPS_EKP.active_to_tmsp AS TIMESTAMP), 'Europe/Berlin'
      )) AS DATETIME) AS ekp_active_to_tmsp,
   FACT_PPS_EKP.curr_cd AS ekp_curr_cd,
   FACT_PPS_EKP.price_eur_val AS ekp_price_eur_val,
   FACT_PPS_EKP.price_local_val AS ekp_price_local_val,
    CASE
    WHEN FACT_PA.avail_lvl_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_PA.avail_lvl_cd, '-1')
    END AS avail_lvl,
   COALESCE(MAX(FACT_PA.avail_lvl_cd) OVER (PARTITION BY FACT_PA.wshop_cd, FACT_PA.cal_dt, CAST(DIM_PV.prod_sid AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), '-1') AS avail_lvl_product,
    CASE
    WHEN AGG_PSD.prod_orderable_lvl_cd = ''
    THEN '-1'
    ELSE IFNULL(AGG_PSD.prod_orderable_lvl_cd, '-1')
    END AS prod_orderable_lvl_cd,
   COALESCE(MAX(AGG_PSD.prod_orderable_lvl_cd) OVER (PARTITION BY AGG_PSD.wshop_cd, AGG_PSD.cust_order_dt, CAST(DIM_PV.prod_sid AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), '-1') AS prod_orderable_lvl_cd_product,
   AGG_SP.first_week_start_dt,
    CASE
    WHEN DATE_DIFF(CURRENT_DATE, AGG_PSD.promo_sale_start_dt, DAY) <= 0 AND CURRENT_DATE < AGG_SP.first_week_start_dt
    THEN 1
    WHEN DATE_DIFF(CURRENT_DATE, AGG_PSD.promo_sale_start_dt, DAY) <= 2 AND CURRENT_DATE < AGG_SP.first_week_start_dt
    THEN 2
    WHEN DATE_DIFF(CURRENT_DATE, AGG_PSD.promo_sale_start_dt, DAY) <= 6 AND CURRENT_DATE < AGG_SP.first_week_start_dt
    THEN 3
    WHEN DATE_DIFF(CURRENT_DATE, AGG_PSD.promo_sale_start_dt, DAY) <= 7 AND CURRENT_DATE < AGG_SP.first_week_start_dt
    THEN 4
    WHEN DATE_DIFF(CURRENT_DATE, AGG_PSD.promo_sale_start_dt, DAY) <= 9 AND CURRENT_DATE < AGG_SP.first_week_start_dt
    THEN 5
    WHEN DATE_DIFF(CURRENT_DATE, AGG_PSD.promo_sale_start_dt, DAY) <= 13 AND CURRENT_DATE < AGG_SP.first_week_start_dt
    THEN 6
    WHEN CURRENT_DATE < AGG_SP.first_week_start_dt
    THEN 7
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 1 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 8
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 3 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 9
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 7 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 10
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 14 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 11
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 21 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 12
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 28 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 13
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 35 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 14
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 42 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 15
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 49 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 16
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 56 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 17
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 63 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 18
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 70 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 19
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 77 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 20
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 84 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 21
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 126 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 22
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 182 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 23
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 224 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 24
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 273 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 25
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 364 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 26
    WHEN DATE_DIFF(CURRENT_DATE, AGG_SP.first_week_start_dt, DAY) < 540 AND CURRENT_DATE >= AGG_SP.first_week_start_dt
    THEN 999
    WHEN CURRENT_DATE >= AGG_SP.first_week_start_dt AND CURRENT_DATE <= LAST_DAY(DATE_ADD(AGG_PSD.promo_sale_start_dt,
        INTERVAL 730 DAY), YEAR)
    THEN 9999
    ELSE NULL
    END AS current_promo_sale_cluster_cd
  FROM CTE_PSD AS AGG_PSD
   INNER JOIN ldl_dig_lec_share.v_fact_currency_exchange_rate AS CER_FACT ON AGG_PSD.curr_cd = CER_FACT.from_curr_cd AND
     AGG_PSD.promo_start_dt BETWEEN CER_FACT.active_from_dt AND CER_FACT.active_to_dt
   INNER JOIN ldl_dig_lec_share.v_dim_currency_exchange_rate_type AS CERT_DIM ON CER_FACT.curr_exchange_rate_type_cd =
     CERT_DIM.curr_exchange_rate_type_cd AND CERT_DIM.is_general_used_fg
   LEFT JOIN CTE_PPC AS FACT_PPC_AKP ON AGG_PSD.prod_variant_sid = FACT_PPC_AKP.prod_variant_sid AND AGG_PSD.wshop_cd =
       FACT_PPC_AKP.wshop_cd AND CAST(PARSE_DATETIME('%F %H:%M:%S', CONCAT(AGG_PSD.promo_start_dt, ' 23:59:59')) AS TIMESTAMP)
      BETWEEN FACT_PPC_AKP.active_from_tmsp AND FACT_PPC_AKP.active_to_tmsp AND FACT_PPC_AKP.price_type_cd = 'AKP'
   LEFT JOIN CTE_PPC AS FACT_PPC_VKP ON AGG_PSD.prod_variant_sid = FACT_PPC_VKP.prod_variant_sid AND AGG_PSD.wshop_cd =
       FACT_PPC_VKP.wshop_cd AND CAST(PARSE_DATETIME('%F %H:%M:%S', CONCAT(AGG_PSD.promo_start_dt, ' 23:59:59')) AS TIMESTAMP)
      BETWEEN FACT_PPC_VKP.active_from_tmsp AND FACT_PPC_VKP.active_to_tmsp AND FACT_PPC_VKP.price_type_cd = 'VKP'
   LEFT JOIN CTE_PPS AS FACT_PPS_EKP ON AGG_PSD.prod_variant_sid = FACT_PPS_EKP.prod_variant_sid AND AGG_PSD.wshop_cd =
       FACT_PPS_EKP.wshop_cd AND CAST(PARSE_DATETIME('%F %H:%M:%S', CONCAT(AGG_PSD.promo_start_dt, ' 23:59:59')) AS TIMESTAMP)
      BETWEEN FACT_PPS_EKP.active_from_tmsp AND FACT_PPS_EKP.active_to_tmsp AND FACT_PPS_EKP.price_type_cd = 'EKP'
   LEFT JOIN ldl_dig_lec_share.v_dim_product_variant AS DIM_PV ON AGG_PSD.prod_variant_sid = DIM_PV.prod_variant_sid AND
    DIM_PV.dwh_valid_fg
   LEFT JOIN ldl_dig_lec_share.v_fact_product_variant_availability AS FACT_PA ON AGG_PSD.wshop_cd = FACT_PA.wshop_cd AND
      AGG_PSD.prod_variant_sid = FACT_PA.prod_variant_sid AND FACT_PA.active_fg
   INNER JOIN ldl_dig_fe_mstr_lidldigital.v_agg_sales_promotion AS AGG_SP ON AGG_PSD.promo_id = AGG_SP.promo_id
  WHERE CER_FACT.to_curr_cd = 'EUR');