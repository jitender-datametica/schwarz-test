CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.bf_shopper_ods (
bon_id STRING(25),
kl_art_id BIGNUMERIC(38,0),
wg_id BIGNUMERIC(38,0),
menge NUMERIC(18,3),
umsatz_brutto NUMERIC(18,4),
aktion_id STRING(10) COLLATE 'und:ci',
mandant_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
talon_id BIGNUMERIC(36,0),
start_bon_zeile DATETIME,
bon_nr BIGNUMERIC(38,0),
bon_dat DATE,
kasse_nr BIGNUMERIC(38,0),
turnover_fg BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);