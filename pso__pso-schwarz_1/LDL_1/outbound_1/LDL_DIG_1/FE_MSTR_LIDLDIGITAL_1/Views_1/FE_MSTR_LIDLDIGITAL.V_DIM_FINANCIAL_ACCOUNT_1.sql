CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_financial_account_1 AS SELECT IFNULL(fin_acct_sid, -1) AS
 fin_acct_sid,
  CASE
  WHEN chart_of_accounts_cd = ''
  THEN '-1'
  ELSE IFNULL(chart_of_accounts_cd, '-1')
  END AS chart_of_accounts_cd,
  CASE
  WHEN acct_nr = ''
  THEN '-1'
  ELSE IFNULL(acct_nr, '-1')
  END AS acct_nr,
  CASE
  WHEN group_acct_nr = ''
  THEN '-1'
  ELSE IFNULL(group_acct_nr, '-1')
  END AS group_acct_nr,
 balance_sheet_acct_fg,
 pl_statement_acct_fg,
 reconciliation_acct_fg,
 cash_acct_fg,
  CASE
  WHEN curr_cd = ''
  THEN '-1'
  ELSE IFNULL(curr_cd, '-1')
  END AS curr_cd,
 short_name_en,
 long_name_en,
 short_name_de,
 long_name_de,
 IFNULL(internal_company_sid, -1) AS internal_company_sid
FROM ldl_dig_lec_share.v_dim_financial_account_1
WHERE dwh_valid_fg
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand0,
 '-1' AS dm__operand1,
 '-1' AS dm__operand2,
 '-1' AS dm__operand3,
 FALSE AS dm__operand4,
 FALSE AS dm__operand5,
 FALSE AS dm__operand6,
 FALSE AS dm__operand7,
 '-1' AS dm__operand8,
 '' AS dm__operand9,
 '' AS dm__operand10,
 '' AS dm__operand11,
 '' AS dm__operand12,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand13;