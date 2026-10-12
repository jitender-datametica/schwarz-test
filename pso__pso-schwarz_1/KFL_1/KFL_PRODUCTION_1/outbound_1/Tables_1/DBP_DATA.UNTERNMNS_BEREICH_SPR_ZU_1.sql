CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.unternmns_bereich_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
unternehmens_bereich_id STRING(2) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
unternehmens_bereich_bez STRING(60) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);