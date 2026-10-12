CREATE OR REPLACE TABLE idq_production_zsm.a017 (
mandt STRING(3),
kappl STRING(2) NOT NULL,
kschl STRING(4) NOT NULL,
lifnr STRING(10) NOT NULL,
matnr STRING(18) NOT NULL,
ekorg STRING(4) NOT NULL,
werks STRING(4) NOT NULL,
esokz STRING(1) NOT NULL,
datbi DATE NOT NULL,
datab DATE,
knumh STRING(10),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (kappl, kschl, lifnr, matnr, ekorg, werks, esokz, datbi) NOT ENFORCED
);