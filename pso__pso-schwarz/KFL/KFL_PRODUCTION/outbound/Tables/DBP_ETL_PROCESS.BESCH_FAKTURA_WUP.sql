CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.besch_faktura_wup (
mandant_id BIGNUMERIC(38,0),
faktura_beleg_id INTEGER,
wup_id BIGNUMERIC(38,0),
dat_wup DATE,
auftraggeber_id BIGNUMERIC(38,0),
dat_auftraggeber DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
);