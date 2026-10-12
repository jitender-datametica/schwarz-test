CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_feststellung_2 (
feststellung_id BIGNUMERIC(38,0) NOT NULL,
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
pruefung_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
pruef_kapitel_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
amx_frage_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
feststellung_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);