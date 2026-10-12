CREATE OR REPLACE TABLE szd_production_etl.buchungskreis_spr_zu (
mandant_id INTEGER NOT NULL,
buchungskreis_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
system_id INTEGER NOT NULL,
buchungskreis_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
strasse STRING(60) COLLATE 'und:ci',
plz STRING(10) COLLATE 'und:ci',
ort STRING(80) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);