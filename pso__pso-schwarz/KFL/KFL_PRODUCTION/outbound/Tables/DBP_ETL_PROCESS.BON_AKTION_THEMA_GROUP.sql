CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.bon_aktion_thema_group (
mandant_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
kl_art_id BIGNUMERIC(38,0),
bon_dat DATE,
dat_von DATE,
dat_bis DATE,
aktion_thema_id STRING(4) COLLATE 'und:ci'
);