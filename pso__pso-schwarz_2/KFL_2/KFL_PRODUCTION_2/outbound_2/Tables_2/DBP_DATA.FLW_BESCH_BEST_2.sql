CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_besch_best_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
best_beleg_id INTEGER NOT NULL,
bestellart_id STRING(4) COLLATE 'und:ci' NOT NULL,
bestell_typ_id STRING(1) COLLATE 'und:ci' NOT NULL,
flw_lief_id BIGNUMERIC(38,0) NOT NULL,
artikelart_id STRING(4) COLLATE 'und:ci' NOT NULL,
abweichung_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
einkaufsorganisation_id BIGNUMERIC(38,0) NOT NULL,
dat_best_beleg DATE,
umrechnungskurs BIGNUMERIC(38,5) DEFAULT 1 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);