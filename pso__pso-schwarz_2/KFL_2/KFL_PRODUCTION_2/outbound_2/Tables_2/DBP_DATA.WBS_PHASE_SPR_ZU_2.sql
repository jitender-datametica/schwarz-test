CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_phase_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
wbs_phase_id BIGNUMERIC(38,0) NOT NULL,
wbs_phase_bez STRING(60) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);