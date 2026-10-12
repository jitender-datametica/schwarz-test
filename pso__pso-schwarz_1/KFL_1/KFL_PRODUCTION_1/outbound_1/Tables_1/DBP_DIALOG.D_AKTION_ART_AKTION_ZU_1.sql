CREATE TABLE IF NOT EXISTS kfl_production_dbp_dialog.d_aktion_art_aktion_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kl_art_id BIGNUMERIC(38,0) NOT NULL,
plan_aktion_id STRING(20) COLLATE 'und:ci' NOT NULL,
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL
);