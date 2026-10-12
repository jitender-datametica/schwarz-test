CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_hauler_1 (hauler_sid, hauler_name, hauler_country_cd) AS SELECT
 hauler_sid,
 hauler_name,
  CASE
  WHEN hauler_country_cd = ''
  THEN '-1'
  ELSE IFNULL(hauler_country_cd, '-1')
  END AS hauler_country_cd
FROM ldl_dig_lec_share.v_dim_hauler_1
WHERE dwh_valid_fg
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 '-1';