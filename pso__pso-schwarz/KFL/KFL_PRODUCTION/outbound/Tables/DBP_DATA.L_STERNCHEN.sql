CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_sternchen (
list_durchg_fg BIGNUMERIC(38,0) NOT NULL,
bezugsweg1_fg BIGNUMERIC(38,0) NOT NULL,
bezugsweg4_fg BIGNUMERIC(38,0) NOT NULL,
kdis0_fg BIGNUMERIC(38,0) NOT NULL,
kdis1_fg BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
sternchen_id STRING(2) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);