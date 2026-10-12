CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_product_stock_age AS SELECT cal_dt,
 prod_variant_sid,
 active_fg,
  CASE
  WHEN prod_stock_age_cluster_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_stock_age_cluster_cd, '-1')
  END AS prod_stock_age_cluster_cd,
 ref_booking_dt,
 first_inbound_dt,
 delta_day_cnt
FROM ldl_dig_lec_share.v_fact_product_stock_age;