CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_disposition_rhythmus_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
disposition_rhythmus_id STRING(3) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);