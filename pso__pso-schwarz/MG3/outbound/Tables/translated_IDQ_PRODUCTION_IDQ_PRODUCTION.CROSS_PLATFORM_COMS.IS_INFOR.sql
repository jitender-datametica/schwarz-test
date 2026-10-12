CREATE OR REPLACE TABLE idq_production_cross_platform_coms.is_infor (
id INTEGER,
source_system STRING(250),
country STRING(3),
timeadded TIMESTAMP,
infostart DATE,
inforend DATE,
finishedstatus INTEGER,
finishedstatusmessage STRING(500),
checklist_id STRING(250)
);