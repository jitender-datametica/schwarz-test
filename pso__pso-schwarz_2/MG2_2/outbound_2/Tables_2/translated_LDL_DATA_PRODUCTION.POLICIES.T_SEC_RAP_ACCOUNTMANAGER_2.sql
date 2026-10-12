CREATE OR REPLACE TABLE ldl_data_production_policies.t_sec_rap_accountmanager_2 (
acct_mgr_district_sid INTEGER NOT NULL,
acct_mgr_district_nr STRING(20),
acct_mgr_district_name STRING(100),
sales_company_nr STRING(20),
iso_country_cd STRING(2) NOT NULL,
benchmark_type_id INTEGER NOT NULL,
login_name_email STRING(250)
)
OPTIONS(description='Table which contains information about the accountmanagers & their login-name for user recognition in session. Table has a denomalized structure optimized for policy use & its perfomance. Original data source - internal organization entity & login-name from OSO data source');