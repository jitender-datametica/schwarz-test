CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_coupon_margin_contribution_2 AS WITH ORDERS AS (SELECT EXTRACT(YEAR
    FROM cust_order_perform_dt) AS cal_year,
   EXTRACT(MONTH FROM cust_order_perform_dt) AS cal_month,
   cust_order_perform_dt,
   cust_order_sid,
   revenue_net_eur_val,
   prod_qty,
   cogs_net_eur_val,
   coupon_change_loss_net_eur_val,
   coupon_write_off_loss_net_eur_val,
   delivery_cost_net_eur_val,
   prod_variant_sid,
   prod_sid,
   is_wine_spirits_fg,
   pack_size_handle_group_cd,
   prod_size_type_group_cd,
   prod_size_handle_group_cd,
   ship_size_handle_group_cd,
   delivery_src_type_cd,
   prod_food_class_cd,
   brand_class_cd,
   prod_org_lvl_name,
   prod_promo_class_cd,
   prod_variant_nr
  FROM ldl_dig_lec_share.v_fact_margin_contribution_order_line_2 AS MCOL
  WHERE is_bundle_header_fg
   OR bundle_header_pos_nr = 0), RETURNS AS (SELECT EXTRACT(YEAR FROM cust_order_return_dt) AS cal_year,
   EXTRACT(MONTH FROM cust_order_return_dt) AS cal_month,
   cust_order_return_dt,
   cust_order_sid,
   revenue_net_eur_val,
   return_prod_qty,
   return_coupon_change_net_eur_val,
   return_coupon_write_off_net_eur_val,
   return_prod_net_eur_val,
   cogs_return_net_eur_val,
   prod_variant_sid
  FROM ldl_dig_lec_share.v_fact_margin_contribution_order_line_2 AS MCOL
  WHERE (is_bundle_header_fg OR bundle_header_pos_nr = 0)
   AND cust_order_return_dt IS NOT NULL), TYPE_COUPON AS (SELECT coupon_id,
   coupon_type_cd
  FROM ldl_dig_lec_share.v_dim_coupon_2 AS DC), PROFIT_LOSS AS (SELECT profit_loss_reason_cd,
   profit_loss_reason_name,
   profit_loss_type_name
  FROM ldl_dig_lec_share.v_dim_profit_loss_reason_2 AS DPLR), AGGR AS (SELECT FC.coupon_validation_nr,
   FC.cust_order_sid,
   FC.prod_variant_sid,
   FC.coupon_id,
   FC.coupon_cd,
   t6.coupon_type_cd,
   FC.coupon_promo_cd,
   FC.profit_loss_reason_cd,
   t8.profit_loss_reason_name,
   t8.profit_loss_type_name,
   'EUR' AS curr_cd,
   FC.wshop_cd,
   FC.prod_qty,
   FC.coupon_validation_tmsp,
   FC.coupon_pos_gross_local_val AS coupon_pos_gross_val,
   'GC' AS gc_lc_cd,
   COALESCE(t1.cal_year, t4.cal_year) AS cal_year,
   COALESCE(t1.cal_month, t4.cal_month) AS cal_month,
   DIM_CAL_DAY.bus_year,
   DIM_CAL_DAY.month_of_bus_year,
   t1.revenue_net_eur_val,
   t1.prod_qty AS prod_qty_new,
   t1.cogs_net_eur_val,
   t1.coupon_change_loss_net_eur_val,
   t1.coupon_write_off_loss_net_eur_val,
   t4.return_coupon_change_net_eur_val,
   t4.return_coupon_write_off_net_eur_val,
   t4.return_prod_net_eur_val,
   t1.delivery_cost_net_eur_val,
   t4.cogs_return_net_eur_val,
   t1.prod_sid,
   t1.is_wine_spirits_fg,
   t1.pack_size_handle_group_cd,
   t1.prod_size_type_group_cd,
   t1.prod_size_handle_group_cd,
   t1.ship_size_handle_group_cd,
   t1.delivery_src_type_cd,
   t1.prod_food_class_cd,
   t1.brand_class_cd,
   t1.prod_org_lvl_name,
   t1.prod_promo_class_cd,
   t1.prod_variant_nr,
   ROW_NUMBER() OVER (PARTITION BY CAST(FC.cust_order_sid AS STRING), CAST(FC.prod_variant_sid AS STRING) ORDER BY FC.coupon_pos_gross_local_val
      IS NULL DESC, FC.coupon_pos_gross_local_val DESC) AS rn
  FROM ldl_dig_lec_share.v_fact_coupon_validation_2 AS FC
   INNER JOIN ORDERS AS t1_2 ON FC.cust_order_sid = t1.cust_order_sid AND FC.prod_variant_sid = t1.prod_variant_sid
   LEFT JOIN RETURNS AS t4 ON FC.cust_order_sid = t4.cust_order_sid AND FC.prod_variant_sid = t4.prod_variant_sid
   INNER JOIN ldl_dig_lec_share.v_dim_cal_day_2 AS DIM_CAL_DAY ON COALESCE(t1.cust_order_perform_dt, t4.cust_order_return_dt
     ) = DIM_CAL_DAY.cal_dt
   LEFT JOIN TYPE_COUPON AS t6 ON FC.coupon_id = t6.coupon_id
   LEFT JOIN PROFIT_LOSS AS t8 ON FC.profit_loss_reason_cd = t8.profit_loss_reason_cd
  WHERE FC.curr_cd = 'EUR'
   AND FC.coupon_pos_gross_local_val <> 0) (SELECT *
  FROM AGGR
  WHERE rn = 1);