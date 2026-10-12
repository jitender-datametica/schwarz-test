CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.mandant_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
mandant_bez STRING(40) COLLATE 'und:ci' NOT NULL,
mandant_kbez STRING(3) COLLATE 'und:ci' NOT NULL,
mandant_sap_id BIGNUMERIC(38,0),
default_wrg STRING(3) COLLATE 'und:ci' NOT NULL,
mandant_sort_id BIGNUMERIC(38,0) NOT NULL,
spaet_lief_tage BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
mandant_sb_id BIGNUMERIC(38,0),
mandant_sb_tf_id BIGNUMERIC(38,0),
mandant_id_ursprung BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);