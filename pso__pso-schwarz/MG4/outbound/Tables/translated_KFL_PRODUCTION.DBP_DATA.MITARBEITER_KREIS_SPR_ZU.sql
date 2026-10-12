CREATE OR REPLACE TABLE kfl_production_dbp_data.mitarbeiter_kreis_spr_zu (
mandant_id INTEGER NOT NULL,
mitarbeiter_kreis_id STRING(2) COLLATE 'und:ci' NOT NULL,
spr_id INTEGER NOT NULL,
mitarbeiterkreis_bez STRING(20) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);