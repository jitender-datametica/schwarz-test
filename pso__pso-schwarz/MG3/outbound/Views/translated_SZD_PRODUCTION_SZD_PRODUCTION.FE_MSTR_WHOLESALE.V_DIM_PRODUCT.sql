CREATE OR REPLACE VIEW szd_production_fe_mstr_wholesale.v_dim_product (prod_sid, dwh_valid_from_tmsp, dwh_valid_to_tmsp
, dwh_valid_fg, ian_nr, prod_name, product_name_txt, prod_division_type_cd, incoterm_name, product_status_cd) AS SELECT
 product_sid AS prod_sid,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 ian_nr,
 product_name AS prod_name,
 product_name_txt,
 product_division_type_cd AS prod_division_type_cd,
 incoterm_name,
 product_status_cd
FROM szd_production_core.t_dim_product
WHERE dwh_valid_fg;