CREATE OR REPLACE TABLE kfl_production_dbp_etl.kmo_marm_1 (
matnr INTEGER,
matnr_char STRING(36) COLLATE 'und:ci',
quellsystem STRING(2) COLLATE 'und:ci',
meinh STRING(6) COLLATE 'und:ci',
brgew NUMERIC(18,3),
gewei STRING(6) COLLATE 'und:ci',
umrez NUMERIC(18,3),
umren NUMERIC(18,3),
laenge NUMERIC(18,3),
breite NUMERIC(18,3),
hoehe NUMERIC(18,3),
bezugsdatum DATE,
mandant_id INTEGER,
td_insert TIMESTAMP
);