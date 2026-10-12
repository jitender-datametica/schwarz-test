CREATE OR REPLACE TABLE kfl_production_dbp_data.reklamationsgrund_spr_zu (
mandant_id INTEGER NOT NULL,
reklamationsgrund_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
reklamationsgrund_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);