CREATE OR REPLACE TABLE smp_production_etl_process.t_fe_dashboard_access_1 (
email STRING(1000) NOT NULL,
PRIMARY KEY (email) NOT ENFORCED
) OPTIONS(description='Emails authorized to operate the Schwarz Media Insights Dashboard');