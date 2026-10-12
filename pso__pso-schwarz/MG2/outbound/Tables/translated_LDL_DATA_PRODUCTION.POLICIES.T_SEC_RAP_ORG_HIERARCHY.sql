CREATE OR REPLACE TABLE ldl_data_production_policies.t_sec_rap_org_hierarchy (
iso_country_cd STRING(50),
sales_company_sid STRING(250),
int_org_sid INTEGER,
acct_mgr_district_nr STRING(250),
acct_mgr_district_sid STRING(250),
sales_mgr_district_nr STRING(250),
sales_mgr_district_sid STRING(250),
sales_company_nr STRING(250),
int_org_type_cd STRING(250),
curr_int_org_nr STRING(250),
country_org_cd STRING(50)
)
OPTIONS(description='Table which contains the needed hierarchy information to enable connecting the information from the security tables within the security views. Loaded based on the CORE_DIM.T_DIM_INTERNAL_ORGANIZATION table.');