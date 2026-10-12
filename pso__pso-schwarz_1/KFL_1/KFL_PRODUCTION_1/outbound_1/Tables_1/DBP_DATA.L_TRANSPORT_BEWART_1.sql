CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_transport_bewart_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lvs_bewart_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0),
nb_id BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);