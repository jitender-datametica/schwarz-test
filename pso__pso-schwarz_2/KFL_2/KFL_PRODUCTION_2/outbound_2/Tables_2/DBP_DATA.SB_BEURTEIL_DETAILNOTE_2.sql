CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sb_beurteil_detailnote_2 (
detailnote_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
bereichsnote_id BIGNUMERIC(38,0) NOT NULL,
note_detail NUMERIC(9,2) NOT NULL,
eindruck_detail STRING(500) COLLATE 'und:ci',
beurteilung_detail_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);