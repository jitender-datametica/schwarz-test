CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_product AS SELECT product_sid,
 bus_country_cd,
 product_nr,
 int_product_nr,
 product_name,
 int_product_name,
 nonfood_fg
FROM ldl_score_core.t_dim_product;