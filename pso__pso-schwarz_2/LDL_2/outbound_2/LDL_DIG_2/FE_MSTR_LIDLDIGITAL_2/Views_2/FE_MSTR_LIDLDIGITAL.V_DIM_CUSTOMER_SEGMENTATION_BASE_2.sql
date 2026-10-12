CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_customer_segmentation_base_2 AS SELECT IFNULL(DIM_CSB.cust_sid,
  -1) AS cust_sid,
  CASE
  WHEN DIM_CSB.cust_type_cd = ''
  THEN '-1'
  ELSE IFNULL(DIM_CSB.cust_type_cd, '-1')
  END AS cust_type_cd,
  CASE
  WHEN DIM_CSB.cust_gender_cd = ''
  THEN '-1'
  ELSE IFNULL(DIM_CSB.cust_gender_cd, '-1')
  END AS cust_gender_cd,
 DIM_CSB.cust_birth_cy,
  CASE
  WHEN DIM_CSB.zip_short_cd = ''
  THEN '-1'
  ELSE IFNULL(DIM_CSB.zip_short_cd, '-1')
  END AS zip_short_cd,
 DIM_CSB.city_name,
 DIM_CSB.country_name,
 IFNULL(DIM_CAS.cust_age_segm_cd, '-1') AS cust_age_segm_cd
FROM ldl_dig_lec_share.v_dim_customer_segmentation_base_2 AS DIM_CSB
 LEFT JOIN ldl_dig_lec_share.v_dim_customer_age_segment_2 AS DIM_CAS ON (EXTRACT(YEAR FROM CURRENT_DATE) - DIM_CSB.cust_birth_cy
     ) BETWEEN DIM_CAS.cust_age_segm_start_year AND (IF(DIM_CAS.cust_age_segm_end_year = - 1, 118, DIM_CAS.cust_age_segm_end_year
     )) AND DIM_CAS.cust_age_segm_type_cd = 'MSTR'
WHERE DIM_CSB.dwh_valid_fg
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand0,
 '-1' AS dm__operand1,
 '-1' AS dm__operand2,
 ROUND(CAST('0' AS BIGNUMERIC), 0) AS dm__operand3,
 '-1' AS dm__operand4,
 '' AS dm__operand5,
 '' AS dm__operand6,
 '-1' AS dm__operand7;