CREATE OR REPLACE TABLE kfl_production_dbp_data.lin_kursgruppe_spr_zu_2 (
lin_kursgruppe_id STRING(10) COLLATE 'und:ci' NOT NULL,
spr_id INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
lin_kursgruppe_bez STRING(255) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);