CREATE OR REPLACE TABLE kfl_production_dbp_etl.dat_wup_last_sale_sk (
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
dat DATE,
bon_beginn DATETIME,
xml_name STRING(255)
);