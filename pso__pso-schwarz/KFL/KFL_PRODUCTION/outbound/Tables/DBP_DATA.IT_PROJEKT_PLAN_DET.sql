CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.it_projekt_plan_det (
it_projekt_id STRING(10) COLLATE 'und:ci' NOT NULL,
plan_revision_id BIGNUMERIC(38,0) NOT NULL,
berichts_position_it_id BIGNUMERIC(38,0) NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
sparte_id BIGNUMERIC(38,0) NOT NULL,
plan_betrag NUMERIC(18,2),
plan_betrag_betrieb NUMERIC(18,2),
ahk_aufwand_kz STRING(3) COLLATE 'und:ci',
ahk_euro NUMERIC(18,2),
ahk_quote NUMERIC(9,4) NOT NULL,
aufwand_euro NUMERIC(18,2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);