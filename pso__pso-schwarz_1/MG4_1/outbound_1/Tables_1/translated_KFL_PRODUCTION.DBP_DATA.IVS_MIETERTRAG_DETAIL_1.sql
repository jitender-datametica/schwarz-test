CREATE OR REPLACE TABLE kfl_production_dbp_data.ivs_mietertrag_detail_1 (
debitor_id INTEGER NOT NULL,
sachkonto_id INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
kjmo INTEGER NOT NULL,
immo_objekt_id STRING(20) COLLATE 'und:ci' NOT NULL,
belegart_id STRING(2) COLLATE 'und:ci' NOT NULL,
konto_betrag NUMERIC(18,4),
wrg_id STRING(3) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);