CREATE OR REPLACE TABLE idq_production_zsm.zsm_mm_zz_sap_2 (
sap_zz STRING(4) NOT NULL,
net_eks NUMERIC(3,0),
calc_start NUMERIC(3,0),
paym_until NUMERIC(3,0),
skonto NUMERIC(5,3),
descr_zz STRING(180),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (sap_zz) NOT ENFORCED
);