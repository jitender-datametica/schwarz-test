CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_product_variant_2 AS SELECT product_variant_sid,
 gtin_nr,
 int_product_nr,
 int_product_name,
 case_size_qty
FROM ldl_score_core.t_dim_product_variant_2;