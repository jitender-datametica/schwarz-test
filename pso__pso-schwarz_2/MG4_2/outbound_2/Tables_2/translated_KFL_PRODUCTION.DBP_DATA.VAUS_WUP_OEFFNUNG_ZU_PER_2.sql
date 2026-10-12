CREATE OR REPLACE TABLE kfl_production_dbp_data.vaus_wup_oeffnung_zu_per_2 (
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
wup_oeffnungs_typ_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
zeit_von INTEGER NOT NULL,
zeit_bis INTEGER NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);