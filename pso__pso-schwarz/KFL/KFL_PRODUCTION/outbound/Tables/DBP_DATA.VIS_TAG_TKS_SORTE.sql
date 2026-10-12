CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vis_tag_tks_sorte (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
tks_sorte_id BIGNUMERIC(38,0) NOT NULL,
tks_sorte_bez STRING(40) COLLATE 'und:ci' NOT NULL,
ums_netto NUMERIC(18,2) DEFAULT 0 NOT NULL,
ums_brutto NUMERIC(18,2) DEFAULT 0 NOT NULL,
menge_liter NUMERIC(18,2) DEFAULT 0 NOT NULL,
anz_kunde BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);