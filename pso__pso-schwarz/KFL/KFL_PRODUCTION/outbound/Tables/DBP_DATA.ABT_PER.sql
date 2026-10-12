CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abt_per (
abt_id BIGNUMERIC(38,0) NOT NULL,
arthiertyp_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);