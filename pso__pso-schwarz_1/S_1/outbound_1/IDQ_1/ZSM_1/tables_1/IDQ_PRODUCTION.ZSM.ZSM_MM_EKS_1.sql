CREATE OR REPLACE TABLE idq_production_zsm.zsm_mm_eks_1 (
mandt STRING(3) NOT NULL,
eksnr NUMERIC(5,0) NOT NULL,
lifnr STRING(10) NOT NULL,
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
zsm_indicator NUMERIC(3,0),
PRIMARY KEY (mandt, eksnr, lifnr) NOT ENFORCED
);