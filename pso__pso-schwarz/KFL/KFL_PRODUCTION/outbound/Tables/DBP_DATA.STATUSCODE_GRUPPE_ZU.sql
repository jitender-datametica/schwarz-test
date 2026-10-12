CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.statuscode_gruppe_zu (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
statuscode_id BIGNUMERIC(38,0) NOT NULL,
statusgruppe_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);