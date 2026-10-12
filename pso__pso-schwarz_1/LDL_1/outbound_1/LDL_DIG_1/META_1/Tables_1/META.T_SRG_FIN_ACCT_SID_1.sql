CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_srg_fin_acct_sid_1 (
fin_acct_sid BIGNUMERIC(38,0),
chart_of_accounts_cd STRING(5),
acct_nr STRING(20),
internal_company_cd STRING(5),
src_table_name STRING(250),
dwh_created_tmsp TIMESTAMP
);