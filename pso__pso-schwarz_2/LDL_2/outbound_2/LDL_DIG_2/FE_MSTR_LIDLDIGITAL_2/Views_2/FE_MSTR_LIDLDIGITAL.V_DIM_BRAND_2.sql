CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_brand_2 (brand_sid, brand_nr, brand_name, brand_class_cd) AS
SELECT brand_sid,
 brand_nr,
 brand_name,
  CASE
  WHEN brand_class_cd = ''
  THEN '-1'
  ELSE IFNULL(brand_class_cd, '-1')
  END AS brand_class_cd
FROM ldl_dig_lec_share.v_dim_brand_2
WHERE dwh_valid_fg
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 '',
 '-1';