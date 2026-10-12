CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_rel_product_variant_akp_days_1 (wshop_cd, prod_variant_sid, cal_dt)
AS SELECT v_fact_product_pricing_condition.wshop_cd,
 v_fact_product_pricing_condition.prod_variant_sid,
 v_dim_cal_day.cal_dt
FROM ldl_dig_lec_share.v_fact_product_pricing_condition_1
 INNER JOIN ldl_dig_lec_share.v_dim_cal_day_1 ON v_dim_cal_day.cal_dt BETWEEN DATE(v_fact_product_pricing_condition.active_from_tmsp
     ) AND (DATE(v_fact_product_pricing_condition.active_to_tmsp)) AND v_fact_product_pricing_condition.price_type_cd =
    'AKP' AND v_dim_cal_day.cal_dt_offset < 0;