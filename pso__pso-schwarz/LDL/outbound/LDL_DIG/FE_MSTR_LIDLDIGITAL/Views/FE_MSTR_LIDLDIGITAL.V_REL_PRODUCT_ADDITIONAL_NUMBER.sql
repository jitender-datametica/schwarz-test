CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_rel_product_additional_number (prod_sid, prod_add_nr_type_cd,
prod_add_nr, is_main_fg) AS SELECT prod_sid,
  CASE
  WHEN prod_add_nr_type_cd = ''
  THEN '-1'
  ELSE IFNULL(prod_add_nr_type_cd, '-1')
  END AS prod_add_nr_type_cd,
 prod_add_nr,
 is_main_fg
FROM ldl_dig_lec_share.v_rel_product_additional_number
WHERE dwh_valid_fg;