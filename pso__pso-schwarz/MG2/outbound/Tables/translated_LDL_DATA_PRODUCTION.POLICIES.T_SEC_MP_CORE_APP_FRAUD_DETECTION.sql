CREATE OR REPLACE TABLE ldl_data_production_policies.t_sec_mp_core_app_fraud_detection (
access_type_cd STRING(16777216),
user_name STRING(16777216),
role_name STRING(16777216)
)
OPTIONS(description='Table contains list of users and roles for which values in masked columns in the CORE_APP_FRAUD_DETECTION should be visible. ');