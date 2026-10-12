CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_supplier_1 AS SELECT supplier_sid,
 supplier_nr,
 supplier_name,
 supplier_full_name,
 IFNULL(addr_sid, -1) AS addr_sid,
 IFNULL(NULLIF(orig_country_cd, ''), '-1') AS orig_country_cd,
 IFNULL(NULLIF(zip_cd, ''), '-1') AS zip_cd,
 city_name,
 street_name,
 supplier_src_insert_dt
FROM ldl_dig_lec_share.v_dim_supplier_1
WHERE dwh_valid_fg
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand0,
 '' AS dm__operand1,
 '' AS dm__operand2,
 '' AS dm__operand3,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand4,
 '-1' AS dm__operand5,
 '-1' AS dm__operand6,
 '' AS dm__operand7,
 '' AS dm__operand8,
 CAST('' AS DATE) AS dm__operand9;