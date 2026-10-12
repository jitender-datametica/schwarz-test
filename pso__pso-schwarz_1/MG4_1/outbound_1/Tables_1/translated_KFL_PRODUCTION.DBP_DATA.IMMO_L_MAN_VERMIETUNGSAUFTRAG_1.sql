CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_l_man_vermietungsauftrag_1 (
mandant_id INTEGER NOT NULL,
man_vermietungsauftrag_id INTEGER DEFAULT 0 NOT NULL,
man_vermietungsauftrag_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);