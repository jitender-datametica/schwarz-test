CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_tax_class_1 (wshop_cd, tax_class_cd, tax_class_pct) AS SELECT
 wshop_cd,
  CASE
  WHEN tax_class_cd = ''
  THEN '-1'
  ELSE IFNULL(tax_class_cd, '-1')
  END AS tax_class_cd,
 tax_class_pct
FROM ldl_dig_lec_share.v_dim_tax_class_1
WHERE active_fg
UNION ALL
SELECT '-1',
 '-1',
 0;