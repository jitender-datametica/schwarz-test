CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_bonuskauf_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
bonuskauf_id STRING(20) COLLATE 'und:ci' NOT NULL,
zeit_von BIGNUMERIC(38,0) NOT NULL,
zeit_bis BIGNUMERIC(38,0) NOT NULL,
konditionsart_id STRING(4) COLLATE 'und:ci' NOT NULL,
geschaeftsvorfall_id STRING(2) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);