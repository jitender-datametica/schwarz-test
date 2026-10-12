CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.inventur_termin_art_wup_zu_per_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat_plan_zaehlung DATE NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
dat_vorletzte_zaehlung DATE NOT NULL,
inventurart_int_vorletzte_zaehlung BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci',
umsatz_vk_netto_sum NUMERIC(18,4) NOT NULL,
inventur_wert_vk_netto NUMERIC(18,2) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);