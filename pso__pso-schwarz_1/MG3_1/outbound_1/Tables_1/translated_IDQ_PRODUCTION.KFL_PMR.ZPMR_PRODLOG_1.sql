CREATE OR REPLACE TABLE idq_production_kfl_pmr.zpmr_prodlog_1 (
mandt STRING(3) NOT NULL,
prod_id STRING(255) NOT NULL,
logsys INTEGER NOT NULL,
sales_org STRING(28) NOT NULL,
dist_channel STRING(28) NOT NULL,
mother_id STRING(255),
prod_group INTEGER,
sstuf STRING(2),
sopo STRING(50),
prod_type STRING(1),
labpr STRING(1),
vpreh INTEGER,
inhal NUMERIC(14,3),
inhme STRING(3),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, prod_id, logsys, sales_org, dist_channel) NOT ENFORCED
);