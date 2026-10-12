CREATE OR REPLACE TABLE idq_production_zsm.wrf_matgrp_strct_2 (
mandt STRING(3),
hier_id STRING(2) NOT NULL,
node STRING(18) NOT NULL,
spras STRING(1) NOT NULL,
ltext STRING(50),
ltextg STRING(50),
ltextlg STRING(60),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (hier_id, node, spras) NOT ENFORCED
);