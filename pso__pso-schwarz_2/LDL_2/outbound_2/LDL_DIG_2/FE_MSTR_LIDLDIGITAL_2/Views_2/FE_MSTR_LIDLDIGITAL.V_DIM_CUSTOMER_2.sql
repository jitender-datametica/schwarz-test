CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_customer_2 AS SELECT IFNULL(cust_sid, -1) AS cust_sid,
 cust_nr,
 cust_salutation,
 cust_first_name,
 cust_last_name,
 cust_birth_dt,
 CAST(FLOOR(DATE_DIFF(CURRENT_DATE, cust_birth_dt, DAY) / 365.25) AS INTEGER) AS cust_age,
  CASE
  WHEN cust_type_cd = ''
  THEN '-1'
  ELSE IFNULL(cust_type_cd, '-1')
  END AS cust_type_cd,
  CASE
  WHEN cust_org_type_cd = ''
  THEN '-1'
  ELSE IFNULL(cust_org_type_cd, '-1')
  END AS cust_org_type_cd,
 cust_company_name,
 IFNULL(cust_billing_addr_sid, -1) AS cust_billing_addr_sid,
 phone_nr,
 email,
  CASE
  WHEN cust_blocked_reason_cd = ''
  THEN '-1'
  ELSE IFNULL(cust_blocked_reason_cd, '-1')
  END AS cust_blocked_reason_cd,
  CASE
  WHEN cust_lan_cd = ''
  THEN '-1'
  ELSE IFNULL(cust_lan_cd, '-1')
  END AS cust_lan_cd,
 cust_sso_id,
 cust_creation_dt,
 cust_registration_dt,
 cust_acct_id,
 is_cust_adv_blocked_fg,
 email_pcu,
 cust_sso_id_pcu,
 is_cust_blocked_pcu_fg,
 is_cust_deleted_pcu_fg
FROM ldl_dig_lec_share.v_dim_customer_2
WHERE dwh_valid_fg
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand0,
 '' AS dm__operand1,
 '' AS dm__operand2,
 '' AS dm__operand3,
 '' AS dm__operand4,
 DATE('1900-01-01') AS dm__operand5,
 ROUND(CAST('0' AS NUMERIC), 6) AS dm__operand6,
 '-1' AS dm__operand7,
 '-1' AS dm__operand8,
 '' AS dm__operand9,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand10,
 '' AS dm__operand11,
 '' AS dm__operand12,
 '-1' AS dm__operand13,
 '-1' AS dm__operand14,
 '-1' AS dm__operand15,
 DATE('1900-01-01') AS dm__operand16,
 DATE('1900-01-01') AS dm__operand17,
 '-1' AS dm__operand18,
 CAST('FALSE' AS BOOL) AS dm__operand19,
 '' AS dm__operand20,
 '' AS dm__operand21,
 CAST('FALSE' AS BOOL) AS dm__operand22,
 CAST('FALSE' AS BOOL) AS dm__operand23;