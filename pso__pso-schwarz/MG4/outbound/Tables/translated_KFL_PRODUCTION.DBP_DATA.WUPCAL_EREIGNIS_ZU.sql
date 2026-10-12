CREATE OR REPLACE TABLE kfl_production_dbp_data.wupcal_ereignis_zu (
dat DATE NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
ereignistyp_id INTEGER NOT NULL,
ereignis_id INTEGER NOT NULL,
offen INTEGER,
td_update TIMESTAMP,
td_insert TIMESTAMP
);