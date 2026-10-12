CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.v_f_lifecycle_hga_sales_1 AS SELECT hga_sid,
 sale_dt,
 payment_type_id,
 hga_product_cat_id,
 curr_cd,
 mug_type_id,
 sale_tm,
 sale_price,
 sale_eur_price,
 lid_fg
FROM szd_core.t_fact_hga_sales_1;