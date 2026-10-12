CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_sales_target_2 (wshop_cd, target_sale_dt, delivery_src_type_cd,
prod_assortment_class_cd, prod_food_class_cd, brand_class_cd, shop_cat_lvl1_sid, shop_cat_lvl1_name, tgt_revenue_net_val
, tgt_margin_val, curr_cd, prod_org_lvl_name, gc_lc_cd, tgt_revenue_net_eur_val, tgt_margin_eur_val, tgt_prod_sale_qty,
tgt_cogs_net_eur_val) AS SELECT TARG_FACT.wshop_cd,
 TARG_FACT.target_sale_dt,
  CASE
  WHEN TARG_FACT.delivery_src_type_cd = ''
  THEN '-1'
  ELSE IFNULL(TARG_FACT.delivery_src_type_cd, '-1')
  END AS delivery_src_type_cd,
  CASE
  WHEN TARG_FACT.prod_assortment_class_cd = ''
  THEN '-1'
  ELSE IFNULL(TARG_FACT.prod_assortment_class_cd, '-1')
  END AS prod_assortment_class_cd,
  CASE
  WHEN TARG_FACT.prod_food_class_cd = ''
  THEN '-1'
  ELSE IFNULL(TARG_FACT.prod_food_class_cd, '-1')
  END AS prod_food_class_cd,
  CASE
  WHEN TARG_FACT.brand_class_cd = ''
  THEN '-1'
  ELSE IFNULL(TARG_FACT.brand_class_cd, '-1')
  END AS brand_class_cd,
 IFNULL(TARG_FACT.shop_cat_lvl1_sid, - 1) AS shop_cat_lvl1_sid,
 TARG_FACT.shop_cat_lvl1_name,
 TARG_FACT.tgt_revenue_net_eur_val AS tgt_revenue_net_val,
 TARG_FACT.tgt_margin_eur_val AS tgt_margin_val,
  CASE
  WHEN TARG_FACT.curr_cd = ''
  THEN '-1'
  ELSE IFNULL(TARG_FACT.curr_cd, '-1')
  END AS curr_cd,
  CASE
  WHEN TARG_FACT.prod_org_lvl_name = ''
  THEN '-1'
  ELSE IFNULL(TARG_FACT.prod_org_lvl_name, '-1')
  END AS prod_org_lvl_name,
 'GC' AS gc_lc_cd,
 TARG_FACT.tgt_revenue_net_eur_val,
 TARG_FACT.tgt_margin_eur_val,
 TARG_FACT.tgt_prod_sale_qty,
  TARG_FACT.tgt_revenue_net_eur_val - TARG_FACT.tgt_margin_eur_val AS tgt_cogs_net_eur_val
FROM ldl_dig_lec_share.v_fact_sales_target_2 AS TARG_FACT
 INNER JOIN ldl_dig_lec_share.v_dim_cal_day_2 AS CAL_DIM ON TARG_FACT.target_sale_dt = CAL_DIM.cal_dt
WHERE TARG_FACT.curr_cd = 'EUR';