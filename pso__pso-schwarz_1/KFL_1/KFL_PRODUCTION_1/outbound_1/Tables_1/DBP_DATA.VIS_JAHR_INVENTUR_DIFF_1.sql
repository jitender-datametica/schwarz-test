CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vis_jahr_inventur_diff_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
umsatz_brutto_inventur NUMERIC(18,4) NOT NULL,
betrag_inventur_differenz NUMERIC(18,4) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);