CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_feststellung_2 (
feststellung_id INTEGER NOT NULL,
amx_system_id INTEGER DEFAULT - 1 NOT NULL,
pruefung_id INTEGER DEFAULT - 1 NOT NULL,
pruef_kapitel_id INTEGER DEFAULT - 1 NOT NULL,
amx_frage_id INTEGER DEFAULT - 1 NOT NULL,
feststellung_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);