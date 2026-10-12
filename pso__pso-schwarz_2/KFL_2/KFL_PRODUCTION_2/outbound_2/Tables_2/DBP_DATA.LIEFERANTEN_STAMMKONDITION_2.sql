CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lieferanten_stammkondition_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
gp_id BIGNUMERIC(38,0) NOT NULL,
einkaufsorganisation_id BIGNUMERIC(38,0),
kondgrp_id BIGNUMERIC(38,0),
dat_von DATE,
kond_art STRING(4) COLLATE 'und:ci',
dat_bis DATE,
wert NUMERIC(9,4),
prozent NUMERIC(7,4),
td_insert TIMESTAMP,
td_update TIMESTAMP
);