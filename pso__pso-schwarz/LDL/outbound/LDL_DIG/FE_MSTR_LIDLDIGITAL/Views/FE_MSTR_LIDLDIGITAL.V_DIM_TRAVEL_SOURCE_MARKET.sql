CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_travel_source_market (trav_source_market_cd,
trav_source_market_name, country_cd) AS SELECT trav_source_market_cd,
 trav_source_market_name,
  CASE
  WHEN country_cd = ''
  THEN '-1'
  ELSE IFNULL(country_cd, '-1')
  END AS country_cd
FROM ldl_dig_lec_share.v_dim_travel_source_market
UNION ALL
SELECT '-1',
 '',
 '-1';