CREATE OR REPLACE TABLE ldl_data_production_etl.t_tmp_lisy_comp_rel_tf (
int_org_nr STRING(16777216),
party_nat_key_nr STRING(16777216),
dwh_valid_from DATETIME,
dwh_valid_to DATETIME,
int_org_name STRING(16777216),
legal_name STRING(3000),
int_org_short_name STRING(3000),
curr_cd STRING(16777216),
country_org_cd STRING(16777216),
country_org_name STRING(100),
is_sales_company_fg BOOL,
is_deliv_company_fg BOOL,
is_expansion_company_fg BOOL,
is_bal_sheet_company_fg BOOL,
is_owner_company_fg BOOL,
is_country_org_fg BOOL
);