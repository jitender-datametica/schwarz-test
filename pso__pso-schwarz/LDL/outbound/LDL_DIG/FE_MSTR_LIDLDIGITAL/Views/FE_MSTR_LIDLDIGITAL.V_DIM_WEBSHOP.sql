CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_webshop (wshop_cd, wshop_name_de, wshop_name_en,
wshop_display_order_nr, country_cd) AS SELECT wshop_cd,
 wshop_name_de,
 wshop_name_en,
 wshop_display_order_nr,
  CASE
  WHEN country_cd = ''
  THEN '-1'
  ELSE IFNULL(country_cd, '-1')
  END AS country_cd
FROM ldl_dig_lec_share.v_dim_webshop
UNION ALL
SELECT '-1',
 '',
 '',
 1000,
 '-1';