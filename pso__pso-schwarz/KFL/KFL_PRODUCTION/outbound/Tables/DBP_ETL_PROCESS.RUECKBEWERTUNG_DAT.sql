CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.rueckbewertung_dat (
mandant_id BIGNUMERIC(38,0),
rb_dat DATE,
rb_pflicht_fg BIGNUMERIC(38,0),
rb_start_dat DATE,
rb_start_ts TIMESTAMP,
td_update TIMESTAMP,
td_insert TIMESTAMP
);