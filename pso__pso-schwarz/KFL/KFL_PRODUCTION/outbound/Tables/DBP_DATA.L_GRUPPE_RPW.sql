CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_gruppe_rpw (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
gruppe_id STRING(20) NOT NULL,
abteilung_id STRING(20) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);