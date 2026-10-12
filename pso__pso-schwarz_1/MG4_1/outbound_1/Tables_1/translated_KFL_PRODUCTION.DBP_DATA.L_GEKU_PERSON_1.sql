CREATE OR REPLACE TABLE kfl_production_dbp_data.l_geku_person_1 (
geku_person_id INTEGER NOT NULL,
name STRING(60) COLLATE 'und:ci',
vorname STRING(60) COLLATE 'und:ci',
orga_nr STRING(60) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);