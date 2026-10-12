CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_coupon_validation_2 (coupon_validation_nr, cust_order_sid,
prod_variant_sid, coupon_id, coupon_cd, coupon_type_cd, coupon_promo_cd, profit_loss_reason_cd, profit_loss_reason_name
, profit_loss_type_name, curr_cd, wshop_cd, prod_qty, coupon_validation_tmsp, coupon_ship_gross_val,
coupon_item_gross_val, coupon_pos_gross_val, gc_lc_cd, cal_year, cal_month, bus_year, month_of_bus_year) AS SELECT FC.coupon_validation_nr
 ,
 FC.cust_order_sid,
 FC.prod_variant_sid,
 FC.coupon_id,
 FC.coupon_cd,
 DC.coupon_type_cd,
 FC.coupon_promo_cd,
 FC.profit_loss_reason_cd,
 DPLR.profit_loss_reason_name,
 DPLR.profit_loss_type_name,
 'EUR' AS curr_cd,
 FC.wshop_cd,
 FC.prod_qty,
 FC.coupon_validation_tmsp,
 FC.coupon_ship_gross_eur_val AS coupon_ship_gross_val,
 FC.coupon_item_gross_eur_val AS coupon_item_gross_val,
 FC.coupon_pos_gross_eur_val AS coupon_pos_gross_val,
 'GC' AS gc_lc_cd,
 EXTRACT(YEAR FROM FC.coupon_validation_tmsp) AS cal_year,
 EXTRACT(MONTH FROM FC.coupon_validation_tmsp) AS cal_month,
 DIM_CAL_DAY.bus_year,
 DIM_CAL_DAY.month_of_bus_year
FROM ldl_dig_fe_mstr_lidldigital.v_fact_coupon_validation_no_gc_lc_2 AS FC
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_coupon_2 AS DC ON FC.coupon_id = DC.coupon_id
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_profit_loss_reason_2 AS DPLR ON FC.profit_loss_reason_cd = DPLR.profit_loss_reason_cd
  
 INNER JOIN ldl_dig_fe_mstr_lidldigital.v_dim_cal_day_2 AS DIM_CAL_DAY ON DATE(FC.coupon_validation_tmsp) = DIM_CAL_DAY.cal_dt
  
UNION DISTINCT
SELECT FC.coupon_validation_nr,
 FC.cust_order_sid,
 FC.prod_variant_sid,
 FC.coupon_id,
 FC.coupon_cd,
 DC.coupon_type_cd,
 FC.coupon_promo_cd,
 FC.profit_loss_reason_cd,
 DPLR.profit_loss_reason_name,
 DPLR.profit_loss_type_name,
 FC.curr_cd,
 FC.wshop_cd,
 FC.prod_qty,
 FC.coupon_validation_tmsp,
 FC.coupon_ship_gross_local_val AS coupon_ship_gross_val,
 FC.coupon_item_gross_local_val AS coupon_item_gross_val,
 FC.coupon_pos_gross_local_val AS coupon_pos_gross_val,
 'LC' AS gc_lc_cd,
 EXTRACT(YEAR FROM FC.coupon_validation_tmsp) AS cal_year,
 EXTRACT(MONTH FROM FC.coupon_validation_tmsp) AS cal_month,
 DIM_CAL_DAY.bus_year,
 DIM_CAL_DAY.month_of_bus_year
FROM ldl_dig_fe_mstr_lidldigital.v_fact_coupon_validation_no_gc_lc_2 AS FC
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_coupon_2 AS DC ON FC.coupon_id = DC.coupon_id
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_profit_loss_reason_2 AS DPLR ON FC.profit_loss_reason_cd = DPLR.profit_loss_reason_cd
  
 INNER JOIN ldl_dig_fe_mstr_lidldigital.v_dim_cal_day_2 AS DIM_CAL_DAY ON DATE(FC.coupon_validation_tmsp) = DIM_CAL_DAY.cal_dt
  
WHERE FC.curr_cd <> 'EUR';