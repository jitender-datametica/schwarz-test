CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_werbekat_1 (
werbe_kat_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
sap_werbe_kat_id STRING(4) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);