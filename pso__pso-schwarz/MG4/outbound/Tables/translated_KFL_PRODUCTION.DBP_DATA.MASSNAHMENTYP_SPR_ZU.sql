CREATE OR REPLACE TABLE kfl_production_dbp_data.massnahmentyp_spr_zu (
massnahmentyp_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
massnahmentyp_bez STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);