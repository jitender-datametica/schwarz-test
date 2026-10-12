CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.hfm_inventur_termin_wg_wup_zu_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
wg_id BIGNUMERIC(38,0) NOT NULL,
arthiertyp_id BIGNUMERIC(38,0) NOT NULL,
dat_plan_zaehlung DATE NOT NULL,
inventurart_int_id BIGNUMERIC(38,0) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci',
dat_vorletzte_zaehlung DATE NOT NULL,
umsatz_vk_netto_sum NUMERIC(18,4) NOT NULL,
inventur_wert_vk_netto NUMERIC(18,2) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);