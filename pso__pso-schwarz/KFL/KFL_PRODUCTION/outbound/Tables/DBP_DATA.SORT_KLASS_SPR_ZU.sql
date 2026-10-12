CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sort_klass_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
klassifizierung_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
klassifizierung_bez STRING(20) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);