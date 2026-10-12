CREATE OR REPLACE TABLE idq_production_zsm.zmmx_md_route_2 (
mandt STRING(3) NOT NULL,
route_id STRING(6) NOT NULL,
supplier_route_id BIGNUMERIC(38,0),
logistic_route_id BIGNUMERIC(38,0),
route_descr_short STRING(25),
route_descr STRING(80),
travelroute_id_old BIGNUMERIC(38,0),
charge_type STRING(1),
land_2 STRING(3),
nr_pos BIGNUMERIC(38,0),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (mandt, route_id) NOT ENFORCED
);