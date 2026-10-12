CREATE OR REPLACE TABLE kfl_production_dbp_data.kjmo_spr_zu_1 (
kjmo INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
kjmo_bez STRING(20) COLLATE 'und:ci',
kjmo_bez_lang STRING(20) COLLATE 'und:ci',
gjmo INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP
);