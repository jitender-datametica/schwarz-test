CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sb_beurteil_bereichsnote_1 (
bereichsnote_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
beurteilung_id BIGNUMERIC(38,0) NOT NULL,
note_bereich NUMERIC(9,2) NOT NULL,
eindruck_bereich STRING(500) COLLATE 'und:ci',
beurteilung_bereich_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);