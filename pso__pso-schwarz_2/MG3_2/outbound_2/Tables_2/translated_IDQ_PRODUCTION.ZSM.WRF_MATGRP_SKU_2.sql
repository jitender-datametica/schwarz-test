CREATE OR REPLACE TABLE idq_production_zsm.wrf_matgrp_sku_2 (
mandt STRING(3),
hier_id STRING(2) NOT NULL,
matnr STRING(18) NOT NULL,
node STRING(18) NOT NULL,
date_from DATE NOT NULL,
date_to DATE,
mainflg STRING(1),
strategy STRING(20),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (hier_id, matnr, node, date_from) NOT ENFORCED
);