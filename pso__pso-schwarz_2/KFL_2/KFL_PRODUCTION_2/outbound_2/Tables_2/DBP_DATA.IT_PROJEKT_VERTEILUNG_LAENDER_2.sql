CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.it_projekt_verteilung_laender_2 (
it_plan_ebene_id BIGNUMERIC(38,0) NOT NULL,
it_projekt_id STRING(10) COLLATE 'und:ci' NOT NULL,
berichts_position_it_id BIGNUMERIC(38,0) NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
verteilung_betrag NUMERIC(18,2),
verteilung_quote NUMERIC(18,4),
td_update TIMESTAMP,
td_insert TIMESTAMP
);