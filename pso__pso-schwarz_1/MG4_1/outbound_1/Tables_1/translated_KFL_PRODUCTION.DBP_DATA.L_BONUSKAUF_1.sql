CREATE OR REPLACE TABLE kfl_production_dbp_data.l_bonuskauf_1 (
mandant_id INTEGER NOT NULL,
bonuskauf_id STRING(20) COLLATE 'und:ci' NOT NULL,
zeit_von INTEGER NOT NULL,
zeit_bis INTEGER NOT NULL,
konditionsart_id STRING(4) COLLATE 'und:ci' NOT NULL,
geschaeftsvorfall_id STRING(2) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);