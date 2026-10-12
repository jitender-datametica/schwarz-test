CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_stueckliste (
stueckliste_id BIGNUMERIC(38,0) NOT NULL,
stueckliste_typ_id STRING(1) COLLATE 'und:ci' NOT NULL,
flw_art_id BIGNUMERIC(38,0),
werk_id BIGNUMERIC(38,0),
flw_stueckliste_verwendung_id STRING(1) COLLATE 'und:ci' NOT NULL,
stueckliste_altnv_id BIGNUMERIC(38,0) NOT NULL,
menge_basis NUMERIC(18,3) NOT NULL,
loesch_fg BIGNUMERIC(38,0) NOT NULL,
loesch_vormerk_fg BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0),
mandant_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);