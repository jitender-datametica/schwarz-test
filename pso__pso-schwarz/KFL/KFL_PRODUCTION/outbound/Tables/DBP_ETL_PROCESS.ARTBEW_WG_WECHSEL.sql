CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.artbew_wg_wechsel (
mandant_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
arthiertyp_id BIGNUMERIC(38,0) NOT NULL,
wg_id BIGNUMERIC(38,0) NOT NULL,
wg_art_fg BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);