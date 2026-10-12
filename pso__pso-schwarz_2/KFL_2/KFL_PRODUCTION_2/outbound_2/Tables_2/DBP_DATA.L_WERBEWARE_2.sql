CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_werbeware_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
werbeware_id STRING(1) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);