CREATE OR REPLACE TABLE szd_production_etl.artkz_verpart_1 (
verpart_id STRING(3) COLLATE 'und:ci' NOT NULL,
mandant_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
verpart_bez STRING(40) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);