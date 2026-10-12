CREATE OR REPLACE TABLE kfl_production_dbp_data.mcx_antwort_spr_zu_1 (
antwort_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
umfrage_id INTEGER DEFAULT - 1 NOT NULL,
antwort_bez STRING(150) COLLATE 'und:ci' NOT NULL,
antwort_datentyp STRING(20) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);