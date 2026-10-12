CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_price_type_1 (price_type_cd, price_type_descr, price_group_cd,
price_type_descr_de) AS SELECT price_type_cd,
 price_type_descr,
  CASE
  WHEN price_group_cd = ''
  THEN '-1'
  ELSE IFNULL(price_group_cd, '-1')
  END AS price_group_cd,
 price_type_descr_de
FROM ldl_dig_lec_share.v_dim_price_type_1
UNION ALL
SELECT '-1',
 '',
 '-1',
 '';