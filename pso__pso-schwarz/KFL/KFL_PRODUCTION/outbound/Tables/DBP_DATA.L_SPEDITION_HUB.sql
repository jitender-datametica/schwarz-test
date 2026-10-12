CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_spedition_hub (
mandant_id BIGNUMERIC(38,0) NOT NULL,
spedition_hub_id BIGNUMERIC(38,0) NOT NULL,
spedition_hub STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);