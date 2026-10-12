CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_product_price_sale_ivp_gld_vkp_no_gc_lc_1 AS SELECT wshop_cd,
 cal_dt,
 IFNULL(prod_variant_sid, - 1) AS prod_variant_sid,
  CASE
  WHEN curr_cd = ''
  THEN '-1'
  ELSE IFNULL(curr_cd, '-1')
  END AS curr_cd,
 gld_price_net_eur_val,
 gld_price_net_local_val,
 ivp_price_net_eur_val,
 ivp_price_net_local_val,
 vkp_price_net_eur_val,
 vkp_price_net_local_val,
 vkp_price_gross_eur_val,
 vkp_price_gross_local_val,
 first_valid_price_fg
FROM ldl_dig_lec_share.v_fact_product_price_sale_ivp_gld_vkp_1
WHERE dwh_valid_fg;