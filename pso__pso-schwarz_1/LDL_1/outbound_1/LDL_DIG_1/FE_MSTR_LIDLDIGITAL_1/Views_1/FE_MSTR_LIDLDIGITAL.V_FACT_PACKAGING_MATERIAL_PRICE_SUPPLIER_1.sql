CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_packaging_material_price_supplier_1 AS SELECT CASE
  WHEN wshop_cd = ''
  THEN '-1'
  ELSE IFNULL(wshop_cd, '-1')
  END AS wshop_cd,
 IFNULL(supplier_sid, -1) AS supplier_sid,
 IFNULL(pack_material_nr, '-1') AS pack_material_nr,
  CASE
  WHEN price_type_cd = ''
  THEN '-1'
  ELSE IFNULL(price_type_cd, '-1')
  END AS price_type_cd,
  CASE
  WHEN price_group_cd = ''
  THEN '-1'
  ELSE IFNULL(price_group_cd, '-1')
  END AS price_group_cd,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(active_from_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
 AS active_from_tmsp,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(active_to_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME
  ) AS active_to_tmsp,
  CASE
  WHEN curr_cd = ''
  THEN '-1'
  ELSE IFNULL(curr_cd, '-1')
  END AS curr_cd,
 price_val,
 prod_qty,
 'GC' AS gc_lc_cd
FROM ldl_dig_lec_share.v_fact_packaging_material_price_supplier_1
WHERE curr_cd = 'EUR'
 AND CURRENT_TIMESTAMP() BETWEEN active_from_tmsp AND active_to_tmsp
UNION ALL
SELECT '-1' AS dm__operand0,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand1,
 '-1' AS dm__operand2,
 '-1' AS dm__operand3,
 '-1' AS dm__operand4,
 PARSE_DATETIME('%F', '1900-01-01') AS dm__operand5,
 PARSE_DATETIME('%F', '1900-01-01') AS dm__operand6,
 '-1' AS dm__operand7,
 ROUND(CAST('0' AS BIGNUMERIC), 5) AS dm__operand8,
 ROUND(CAST('0' AS BIGNUMERIC), 0) AS dm__operand9,
 '-1' AS dm__operand10;