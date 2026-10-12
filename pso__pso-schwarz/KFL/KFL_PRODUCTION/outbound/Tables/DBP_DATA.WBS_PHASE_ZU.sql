CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_phase_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ausliefergruppe_id STRING(10) COLLATE 'und:ci' NOT NULL,
anz_tage_vor_aktion BIGNUMERIC(38,0) NOT NULL,
wbs_phase_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);