CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sb_beurteil_detail_spr_zu_1 (
beurteilung_detail_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
beurteilung_detail_bez STRING(50) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);