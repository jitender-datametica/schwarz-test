CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_agg_order_sales_daily_2 (wshop_cd, cal_dt, prod_sale_type_cd,
cust_order_sid, cancel_cust_order_sid, after_cancel_cust_order_sid, prod_sid, prod_assortment_class_cd, prod_family_cd,
prod_food_class_cd, brand_class_cd, brand_nr, prod_org_lvl_name, prod_manager_cd, prod_subgroup_cd, prod_group_ldt_cd,
delivery_src_type_cd) AS SELECT DISTINCT COL.wshop_cd,
 COL.cust_order_dt AS cal_dt,
 COL.prod_sale_type_cd,
 COL.cust_order_sid,
  CASE
  WHEN COL.is_order_cancel_fg
  THEN COL.cust_order_sid
  ELSE NULL
  END AS cancel_cust_order_sid,
  CASE
  WHEN NOT COL.is_order_cancel_fg
  THEN COL.cust_order_sid
  ELSE NULL
  END AS after_cancel_cust_order_sid,
 COL.prod_sid,
 PRD.prod_assortment_class_cd,
 PRD.prod_family_cd,
 PRD.prod_food_class_cd,
 PRD.brand_class_cd,
 PRD.brand_nr,
 PRD.prod_org_lvl_name,
 PRD.prod_manager_cd,
 PRD.prod_subgroup_cd,
 PRD.prod_group_ldt_cd,
 REG.delivery_src_type_cd
FROM ldl_dig_lec_share.v_fact_customer_order_line_2 AS COL
 LEFT JOIN ldl_dig_lec_share.v_dim_product_2 AS PRD ON COL.prod_sid = PRD.prod_sid AND PRD.dwh_valid_fg
 LEFT JOIN ldl_dig_lec_share.v_rel_product_regional_2 AS REG ON PRD.prod_sid = REG.prod_sid AND COL.wshop_cd = REG.wshop_cd
     AND REG.dwh_valid_fg
WHERE COL.cust_order_dt >= DATE '2019-01-01';