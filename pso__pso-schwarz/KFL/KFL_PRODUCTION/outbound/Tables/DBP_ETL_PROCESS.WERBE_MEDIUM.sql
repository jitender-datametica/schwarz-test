CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.werbe_medium (
art_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
sap_werbe_kat_id STRING(18) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
mutter_wb_id BIGNUMERIC(38,0) NOT NULL,
aktion_thema_id STRING(8) COLLATE 'und:ci' NOT NULL,
bs_kz STRING(4) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);