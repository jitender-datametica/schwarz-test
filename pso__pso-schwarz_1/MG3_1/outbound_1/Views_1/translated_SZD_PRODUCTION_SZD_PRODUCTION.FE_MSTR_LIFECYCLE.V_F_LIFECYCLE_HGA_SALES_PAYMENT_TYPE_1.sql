CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.v_f_lifecycle_hga_sales_payment_type_1 (hga_sid, sale_dt,
payment_type_id, hga_product_cat_id, curr_cd, mug_type_id, sale_tm, sale_price, sale_eur_price, lid_fg, sales_cnt) AS
SELECT hga_sid,
 sale_dt,
 payment_type_id,
 hga_product_cat_id,
 curr_cd,
 mug_type_id,
 sale_tm,
 sale_price,
 sale_eur_price,
 lid_fg,
 COUNT(hga_sid) AS sales_cnt
FROM szd_production_core.t_fact_hga_sales_1
GROUP BY hga_sid,
 sale_dt,
 payment_type_id,
 hga_product_cat_id,
 curr_cd,
 mug_type_id,
 sale_tm,
 sale_price,
 sale_eur_price,
 lid_fg;