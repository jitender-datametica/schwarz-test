CREATE OR REPLACE TABLE idq_production_cross_platform_coms.is_infor_1 (
id BIGNUMERIC(38,0),
source_system STRING(250),
country_1 STRING(3),
timeadded TIMESTAMP,
infostart DATE,
inforend DATE,
finishedstatus BIGNUMERIC(38,0),
finishedstatusmessage STRING(500),
checklist_id STRING(250)
);