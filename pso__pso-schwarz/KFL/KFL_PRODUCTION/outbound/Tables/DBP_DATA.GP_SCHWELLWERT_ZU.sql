CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gp_schwellwert_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
gp_id BIGNUMERIC(38,0) NOT NULL,
sw_id BIGNUMERIC(38,0) NOT NULL,
kj BIGNUMERIC(38,0) NOT NULL,
sw_oben NUMERIC(9,6) NOT NULL,
sw_unten NUMERIC(9,6) NOT NULL,
sw_fg BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);