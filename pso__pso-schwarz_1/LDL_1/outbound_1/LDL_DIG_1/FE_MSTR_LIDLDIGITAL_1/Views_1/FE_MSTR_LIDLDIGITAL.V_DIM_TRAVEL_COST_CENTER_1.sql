CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_travel_cost_center_1 (trav_cost_center_cd, trav_source_market_cd
, trav_cost_center_descr) AS SELECT trav_cost_center_cd,
  CASE
  WHEN trav_source_market_cd = ''
  THEN '-1'
  ELSE IFNULL(trav_source_market_cd, '-1')
  END AS trav_source_market_cd,
 trav_cost_center_descr
FROM ldl_dig_lec_share.v_dim_travel_cost_center_1
UNION ALL
SELECT '-1',
 '-1',
 '';