CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.markt_vz_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
vz_wup_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
entfernung BIGNUMERIC(38,0) NOT NULL,
direkte_zuordnung_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);