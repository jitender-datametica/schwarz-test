CREATE OR REPLACE TABLE idq_production_kfl_ret.a017 (
mandt STRING(3) NOT NULL,
kappl STRING(2) NOT NULL,
kschl STRING(4) NOT NULL,
lifnr STRING(10) NOT NULL,
matnr STRING(40) NOT NULL,
ekorg STRING(4) NOT NULL,
werks STRING(4) NOT NULL,
esokz STRING(1) NOT NULL,
datbi STRING(21) NOT NULL,
datab STRING(21),
knumh STRING(10),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, kappl, kschl, lifnr, matnr, ekorg, werks, esokz, datbi) NOT ENFORCED
);