CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mdl_frage_befragung_bereich_kategorie_zu (
frage_id BIGNUMERIC(38,0) NOT NULL,
befragung_id BIGNUMERIC(38,0) NOT NULL,
bereich_id BIGNUMERIC(38,0) NOT NULL,
kategorie_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);