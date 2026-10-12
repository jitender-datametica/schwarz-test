CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mwst_per_2 (
mwst_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
mwst NUMERIC(12,2) NOT NULL,
dat_bis DATE NOT NULL,
mwst_bez STRING(20) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
sap_mwst_id STRING(1) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);