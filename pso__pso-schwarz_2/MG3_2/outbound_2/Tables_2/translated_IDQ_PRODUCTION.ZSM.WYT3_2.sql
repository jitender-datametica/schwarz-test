CREATE OR REPLACE TABLE idq_production_zsm.wyt3_2 (
mandt STRING(3) NOT NULL,
lifnr STRING(10) NOT NULL,
ekorg STRING(4) NOT NULL,
ltsnr STRING(6) NOT NULL,
werks STRING(4) NOT NULL,
parvw STRING(2) NOT NULL,
parza INTEGER NOT NULL,
ernam STRING(12),
erdat DATE,
lifn2 STRING(10),
defpa STRING(1),
pernr INTEGER,
parnr INTEGER,
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, lifnr, ekorg, ltsnr, werks, parvw, parza) NOT ENFORCED
);