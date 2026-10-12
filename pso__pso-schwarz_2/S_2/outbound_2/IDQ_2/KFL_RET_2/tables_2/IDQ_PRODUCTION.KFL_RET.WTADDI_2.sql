CREATE OR REPLACE TABLE idq_production_kfl_ret.wtaddi_2 (
mandt STRING(3),
matnr STRING(40) NOT NULL,
lfdnr NUMERIC(4,0) NOT NULL,
addiclint NUMERIC(10,0),
addimat STRING(40),
addivkme STRING(3),
addifm STRING(4),
addiinvoc STRING(1),
addiprass STRING(1),
addicalc STRING(1),
mtxid STRING(2),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (matnr, lfdnr) NOT ENFORCED
);