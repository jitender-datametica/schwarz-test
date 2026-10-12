CREATE OR REPLACE TABLE kfl_production_dbp_data.mwst_per (
mwst_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
mandant_id INTEGER NOT NULL,
mwst NUMERIC(12,2) NOT NULL,
dat_bis DATE NOT NULL,
mwst_bez STRING(20) COLLATE 'und:ci' NOT NULL,
spr_id INTEGER NOT NULL,
sap_mwst_id STRING(1) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);