CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_chart_of_accounts (chart_of_accounts_cd, chart_of_acct_name_en
, chart_of_acct_name_de) AS SELECT chart_of_accounts_cd,
 chart_of_acct_name_en,
 chart_of_acct_name_de
FROM ldl_dig_lec_share.v_dim_chart_of_accounts
UNION ALL
SELECT '-1',
 '',
 '';