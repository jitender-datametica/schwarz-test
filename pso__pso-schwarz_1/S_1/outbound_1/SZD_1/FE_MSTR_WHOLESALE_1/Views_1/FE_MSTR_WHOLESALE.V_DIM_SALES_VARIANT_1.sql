CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_sales_variant_1 (product_sid, sales_variant_product_group_sid,
sales_variant_nr, sales_variant_name, dwh_valid_from, dwh_valid_to, dwh_valid_fg) AS SELECT product_sid,
 sales_variant_product_group_sid,
 sales_variant_nr,
 sales_variant_name,
 DATE(dwh_valid_from_tmsp) AS dwh_valid_from,
 DATE(dwh_valid_to_tmsp) AS dwh_valid_to,
 dwh_valid_fg
FROM szd_core.t_dim_sales_variant_1
WHERE dwh_valid_fg;