CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement_1 (uom_sid, uom_cd, uom_descr,
uom_standard_sid, uom_standard_cd, uom_standard_multipl_meas) AS SELECT uom_sid,
  CASE
  WHEN uom_cd = ''
  THEN '-1'
  ELSE IFNULL(uom_cd, '-1')
  END AS uom_cd,
 uom_descr,
 IFNULL(uom_standard_sid, -1) AS `end`,
  CASE
  WHEN uom_standard_cd = ''
  THEN '-1'
  ELSE IFNULL(uom_standard_cd, '-1')
  END AS uom_standard_cd,
 uom_standard_multipl_meas
FROM ldl_dig_lec_share.v_dim_unit_of_measurement_1
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 '',
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 CAST('1' AS BIGNUMERIC);