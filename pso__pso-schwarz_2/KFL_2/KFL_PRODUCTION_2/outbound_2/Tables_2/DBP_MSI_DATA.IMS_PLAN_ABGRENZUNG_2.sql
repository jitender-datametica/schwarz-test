CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ims_plan_abgrenzung_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
psp_id BIGNUMERIC(38,0) NOT NULL,
gjmo BIGNUMERIC(38,0) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
dat_baubeginn DATE,
dat_beginn_einrichtung DATE,
dat_beginn_kaelte DATE,
dat_stille_eroeffnung DATE,
dat_bauabnahme DATE,
anz_tage_massnahme_gesamt BIGNUMERIC(38,0),
anz_tage_massnahme_bis_gjmo BIGNUMERIC(38,0),
plan_abgrenzung_wert_gesamt NUMERIC(18,2) NOT NULL,
plan_abgrenzung_wert_bis_gjmo NUMERIC(18,2),
betrag_ist_bis_gjmo NUMERIC(18,2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);