CREATE OR REPLACE TABLE idq_production_zsm.t024_2 (
mandt STRING(3),
ekgrp STRING(3) NOT NULL,
eknam STRING(18),
ektel STRING(12),
ldest STRING(4),
telfx STRING(31),
tel_number STRING(30),
tel_extens STRING(10),
smtp_addr STRING(241),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (ekgrp) NOT ENFORCED
);