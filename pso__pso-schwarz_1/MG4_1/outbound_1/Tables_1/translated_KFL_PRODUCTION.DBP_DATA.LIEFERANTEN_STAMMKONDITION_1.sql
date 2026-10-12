CREATE OR REPLACE TABLE kfl_production_dbp_data.lieferanten_stammkondition_1 (
mandant_id INTEGER NOT NULL,
gp_id INTEGER NOT NULL,
einkaufsorganisation_id INTEGER,
kondgrp_id INTEGER,
dat_von DATE,
kond_art STRING(4) COLLATE 'und:ci',
dat_bis DATE,
wert NUMERIC(9,4),
prozent NUMERIC(7,4),
td_insert TIMESTAMP,
td_update TIMESTAMP
);