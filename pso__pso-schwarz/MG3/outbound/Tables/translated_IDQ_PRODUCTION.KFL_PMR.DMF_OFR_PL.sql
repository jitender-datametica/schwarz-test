CREATE OR REPLACE TABLE idq_production_kfl_pmr.dmf_ofr_pl (
mandt STRING(3),
db_key STRING(255),
prod_id STRING(255),
parent_key STRING(255),
node_cat_key STRING(255),
loc_id STRING(255),
tstmp_fr INTEGER,
tstmp_to INTEGER,
ofr_trm_dtl_id STRING(255),
currency STRING(255),
price_net NUMERIC(20,5),
price_vat NUMERIC(20,5),
zztheme STRING(255)
);