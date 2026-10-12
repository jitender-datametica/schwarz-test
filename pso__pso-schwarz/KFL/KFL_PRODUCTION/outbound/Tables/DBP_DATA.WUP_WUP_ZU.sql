CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_wup_zu (
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id_ref BIGNUMERIC(38,0) NOT NULL,
nb_id_ref BIGNUMERIC(38,0) NOT NULL,
mandant_id_ref BIGNUMERIC(38,0) NOT NULL,
entfernung_km NUMERIC(9,2) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);