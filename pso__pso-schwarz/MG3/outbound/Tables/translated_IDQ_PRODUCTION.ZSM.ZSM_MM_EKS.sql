CREATE OR REPLACE TABLE idq_production_zsm.zsm_mm_eks (
mandt STRING(3) NOT NULL,
eksnr INTEGER NOT NULL,
lifnr STRING(10) NOT NULL,
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
zsm_indicator INTEGER,
PRIMARY KEY (mandt, eksnr, lifnr) NOT ENFORCED
);