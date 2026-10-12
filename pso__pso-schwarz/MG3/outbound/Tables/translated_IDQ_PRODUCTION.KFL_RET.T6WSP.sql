CREATE OR REPLACE TABLE idq_production_kfl_ret.t6wsp (
mandt STRING(3) NOT NULL,
saiso STRING(4) NOT NULL,
tgvon STRING(5),
tgbis STRING(5),
grukz STRING(2),
vllis INTEGER,
nllis INTEGER,
vlvkf INTEGER,
nlvkf INTEGER,
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, saiso) NOT ENFORCED
);