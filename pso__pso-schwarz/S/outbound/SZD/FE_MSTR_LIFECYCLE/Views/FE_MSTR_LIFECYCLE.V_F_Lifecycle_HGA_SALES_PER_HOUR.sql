CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.v_f_lifecycle_hga_sales_per_hour AS SELECT hga_sid,
 sale_dt,
 sale_hour,
 hga_product_cat_id,
 product_sale_cnt
FROM szd_core.t_fact_hga_sales_per_hour;