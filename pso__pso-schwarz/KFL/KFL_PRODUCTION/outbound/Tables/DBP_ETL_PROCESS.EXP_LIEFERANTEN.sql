CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.exp_lieferanten (
mandant_id BIGNUMERIC(38,0) NOT NULL,
gp_id BIGNUMERIC(38,0) NOT NULL,
gp_exp_name STRING(40) COLLATE 'und:ci' NOT NULL,
periodizitaet STRING(40) COLLATE 'und:ci' NOT NULL,
nachlieferung_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
pset_name STRING(40) COLLATE 'und:ci' DEFAULT '' NOT NULL,
aktiv_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);