CREATE OR REPLACE TABLE idq_production_cross_platform_coms.dq_status_extractor_detail (
id BIGNUMERIC(38,0),
branch STRING(10) NOT NULL,
country STRING(10) NOT NULL,
sap_system STRING(50) NOT NULL,
sap_table_name STRING(50) NOT NULL,
delta_type STRING(50) NOT NULL,
data_extraction_start TIMESTAMP NOT NULL,
data_extraction_end TIMESTAMP,
data_extraction_status_id BIGNUMERIC(38,0) NOT NULL,
number_of_records BIGNUMERIC(38,0)
);