CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_flaeche_aktivitaet_2 (
flaeche_id STRING(20) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
aktivitaet_typ_id BIGNUMERIC(38,0) NOT NULL,
dat_aktivitaet DATE NOT NULL,
aktivitaet_status BIGNUMERIC(38,0),
aktivitaet_bez STRING(100) COLLATE 'und:ci',
aktivitaet_ergebnis STRING(1200) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);