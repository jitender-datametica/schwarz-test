-- dummy_1 values (can be removed onced fields are unmapped in MSTR)

-- dummy_1 values (can be removed onced fields are unmapped in MSTR)

-- dummy_1 values (can be removed onced fields are unmapped in MSTR)

-- dummy_1 values (can be removed onced fields are unmapped in MSTR)

-- dummy_1 values (can be removed onced fields are unmapped in MSTR)

-- dummy_1 values (can be removed onced fields are unmapped in MSTR)

-- dummy_1 values (can be removed onced fields are unmapped in MSTR)

-- dummy_1 values (can be removed onced fields are unmapped in MSTR)

-- dummy_1 values (can be removed onced fields are unmapped in MSTR)

-- dummy_1 values (can be removed onced fields are unmapped in MSTR)

-- dummy_1 values (can be removed onced fields are unmapped in MSTR)

-- dummy_1 values (can be removed onced fields are unmapped in MSTR)

-- dummy_1 values (can be removed onced fields are unmapped in MSTR)

-- dummy_1 values (can be removed onced fields are unmapped in MSTR)

-- dummy_1 values (can be removed onced fields are unmapped in MSTR)

-- dummy_1 values (can be removed onced fields are unmapped in MSTR)

CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_agg_promotion_sales_daily_1 AS SELECT wshop_cd,
 promo_id,
 prod_variant_sid,
 cust_order_dt,
 promo_start_dt,
 promo_sale_start_dt,
 is_special_analysis_fg,
 is_special_analysis_cd,
 'EUR' AS curr_cd,
 prod_price_net_eur_val AS prod_price_net_val,
 cogs_price_net_eur_val AS cogs_price_net_val,
 prod_qty,
 cancel_prod_price_net_eur_val AS cancel_prod_price_net_val,
 cancel_prod_qty,
 return_prod_price_net_eur_val AS return_prod_price_net_val,
 return_prod_qty,
 total_prod_price_net_eur_val AS total_prod_price_net_val,
 total_prod_qty,
 prod_price_gross_eur_val AS prod_price_gross_val,
 cancel_prod_price_gross_eur_val AS cancel_prod_price_gross_val,
 return_prod_price_gross_eur_val AS return_prod_price_gross_val,
 total_prod_price_gross_eur_val AS total_prod_price_gross_val,
 promo_sale_cluster_cd,
 max_sales_cluster_cd,
 prod_variant_nr,
 is_after_cancellation_fg,
 price_type_cd,
 price_group_cd,
 ppc_active_from_tmsp,
 ppc_active_to_tmsp,
 'EUR' AS ppc_curr_cd,
 ppc_price_eur_val AS ppc_price_val,
 ppc_active_from_tmsp AS akp_active_from_tmsp,
 ppc_active_to_tmsp AS akp_active_to_tmsp,
 'EUR' AS akp_curr_cd,
 ppc_price_eur_val AS akp_price_val,
 CAST(NULL AS DATETIME) AS vkp_active_from_tmsp,
 CAST(NULL AS DATETIME) AS vkp_active_to_tmsp,
 CAST(NULL AS STRING) AS vkp_curr_cd,
 CAST(NULL AS BIGNUMERIC) AS vkp_price_val,
 price_change_reason_cd,
 ekp_active_from_tmsp,
 ekp_active_to_tmsp,
 'EUR' AS ekp_curr_cd,
 ekp_price_eur_val AS ekp_price_val,
 avail_lvl,
 avail_lvl_product,
 prod_orderable_lvl_cd,
 prod_orderable_lvl_cd_product,
 'GC' AS gc_lc_cd,
 first_week_start_dt,
 current_promo_sale_cluster_cd
FROM ldl_dig_fe_mstr_lidldigital.v_agg_promotion_sales_daily_no_gc_lc_1
UNION ALL
SELECT wshop_cd,
 promo_id,
 prod_variant_sid,
 cust_order_dt,
 promo_start_dt,
 promo_sale_start_dt,
 is_special_analysis_fg,
 is_special_analysis_cd,
 curr_cd,
 prod_price_net_local_val AS prod_price_net_val,
 cogs_price_net_local_val AS cogs_price_net_val,
 prod_qty,
 cancel_prod_price_net_local_val AS cancel_prod_price_net_val,
 cancel_prod_qty,
 return_prod_price_net_local_val AS return_prod_price_net_val,
 return_prod_qty,
 total_prod_price_net_local_val AS total_prod_price_net_val,
 total_prod_qty,
 prod_price_gross_local_val AS prod_price_gross_val,
 cancel_prod_price_gross_local_val AS cancel_prod_price_gross_val,
 return_prod_price_gross_local_val AS return_prod_price_gross_val,
 total_prod_price_gross_local_val AS total_prod_price_gross_val,
 promo_sale_cluster_cd,
 max_sales_cluster_cd,
 prod_variant_nr,
 is_after_cancellation_fg,
 price_type_cd,
 price_group_cd,
 ppc_active_from_tmsp,
 ppc_active_to_tmsp,
 ppc_curr_cd,
 ppc_price_local_val AS ppc_price_val,
 ppc_active_from_tmsp AS akp_active_from_tmsp,
 ppc_active_to_tmsp AS akp_active_to_tmsp,
 ppc_curr_cd AS akp_curr_cd,
 ppc_price_local_val AS akp_price_val,
 CAST(NULL AS DATETIME) AS vkp_active_from_tmsp,
 CAST(NULL AS DATETIME) AS vkp_active_to_tmsp,
 CAST(NULL AS STRING) AS vkp_curr_cd,
 CAST(NULL AS BIGNUMERIC) AS vkp_price_val,
 price_change_reason_cd,
 ekp_active_from_tmsp,
 ekp_active_to_tmsp,
 ekp_curr_cd,
 ekp_price_local_val AS ekp_price_val,
 avail_lvl,
 avail_lvl_product,
 prod_orderable_lvl_cd,
 prod_orderable_lvl_cd_product,
 'LC' AS gc_lc_cd,
 first_week_start_dt,
 current_promo_sale_cluster_cd
FROM ldl_dig_fe_mstr_lidldigital.v_agg_promotion_sales_daily_no_gc_lc_1
WHERE curr_cd <> 'EUR';