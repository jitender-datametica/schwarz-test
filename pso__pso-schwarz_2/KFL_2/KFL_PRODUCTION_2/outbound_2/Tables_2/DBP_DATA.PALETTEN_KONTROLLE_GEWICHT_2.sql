CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.paletten_kontrolle_gewicht_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
handling_unit_id INTEGER NOT NULL,
handling_unit_id_traeger INTEGER NOT NULL,
status_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
gewicht_ist NUMERIC(18,3) DEFAULT 0 NOT NULL,
gewicht_soll NUMERIC(18,3) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);