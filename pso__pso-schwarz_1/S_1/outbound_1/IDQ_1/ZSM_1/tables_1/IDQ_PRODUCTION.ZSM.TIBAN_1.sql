CREATE OR REPLACE TABLE idq_production_zsm.tiban_1 (
mandt STRING(3) NOT NULL,
banks STRING(3) NOT NULL,
bankl STRING(15) NOT NULL,
bankn STRING(35) NOT NULL,
bkont STRING(2) NOT NULL,
iban STRING(34),
valid_from DATE,
ernam STRING(12),
erdat DATE,
tabname STRING(16),
tabkey STRING(24),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, banks, bankl, bankn, bkont) NOT ENFORCED
);