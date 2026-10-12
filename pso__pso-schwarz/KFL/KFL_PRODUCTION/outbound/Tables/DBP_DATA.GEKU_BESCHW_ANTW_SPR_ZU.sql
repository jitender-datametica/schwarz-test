CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_beschw_antw_spr_zu (
beschwerde_antwort_id INTEGER NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
beschwerde_antw_bez STRING(255) COLLATE 'und:ci',
quelle_spr_id BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);