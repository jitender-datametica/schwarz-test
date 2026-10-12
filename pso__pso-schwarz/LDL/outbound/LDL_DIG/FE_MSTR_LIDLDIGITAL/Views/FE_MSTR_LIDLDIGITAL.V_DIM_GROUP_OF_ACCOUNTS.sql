CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_group_of_accounts AS SELECT CASE
  WHEN chart_of_accounts_cd = ''
  THEN '-1'
  ELSE IFNULL(chart_of_accounts_cd, '-1')
  END AS chart_of_accounts_cd,
 acct_nr AS group_acct_nr,
  CASE
  WHEN curr_cd = ''
  THEN '-1'
  ELSE IFNULL(curr_cd, '-1')
  END AS curr_cd,
 MAX(short_name_en) AS short_name_en,
 MAX(long_name_en) AS long_name_en,
 MAX(short_name_de) AS short_name_de,
 MAX(long_name_de) AS long_name_de
FROM ldl_dig_lec_share.v_dim_financial_account
WHERE dwh_valid_fg
GROUP BY chart_of_accounts_cd,
 group_acct_nr,
 curr_cd
UNION ALL
SELECT '-1' AS dm__operand0,
 '-1' AS dm__operand1,
 '' AS dm__operand2,
 '' AS dm__operand3,
 '' AS dm__operand4,
 '' AS dm__operand5,
 '' AS dm__operand6;