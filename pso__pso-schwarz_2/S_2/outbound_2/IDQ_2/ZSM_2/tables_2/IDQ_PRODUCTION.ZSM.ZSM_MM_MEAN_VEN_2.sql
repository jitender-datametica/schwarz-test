CREATE OR REPLACE TABLE idq_production_zsm.zsm_mm_mean_ven_2 (
mandt STRING(3),
matnr STRING(40) NOT NULL,
ean11 STRING(18) NOT NULL,
ekorg STRING(4) NOT NULL,
lifnr STRING(10),
aenam STRING(12),
aedat STRING(24),
ernam STRING(12),
erdat STRING(24),
eannr_desc STRING(30),
eannr_desc_mlm STRING(30),
PRIMARY KEY (matnr, ean11, ekorg) NOT ENFORCED
);