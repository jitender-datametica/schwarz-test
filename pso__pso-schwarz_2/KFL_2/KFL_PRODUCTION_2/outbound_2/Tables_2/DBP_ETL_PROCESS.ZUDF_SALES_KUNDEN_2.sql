CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.zudf_sales_kunden_2 (
mandant_id BIGNUMERIC(38,0),
dat DATE,
wup_id BIGNUMERIC(38,0),
art_id BIGNUMERIC(38,0),
aktion_id STRING(10) COLLATE 'und:ci',
anz_kunde INTEGER
);