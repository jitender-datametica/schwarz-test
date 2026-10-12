CREATE OR REPLACE TABLE kfl_production_dbp_data.in_lieferant_1 (
in_lief_id INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
lief_name_1 STRING(40) COLLATE 'und:ci' NOT NULL,
lief_name_2 STRING(40) COLLATE 'und:ci' NOT NULL,
gp_ort STRING(40) COLLATE 'und:ci' NOT NULL,
gp_plz STRING(10) COLLATE 'und:ci' NOT NULL,
in_lief_nr STRING(10) COLLATE 'und:ci' NOT NULL,
mandant_id_werk INTEGER NOT NULL,
system_id INTEGER NOT NULL,
loesch_fg INTEGER NOT NULL,
in_lief_id_int INTEGER DEFAULT 0 NOT NULL,
subkategorie_1_id INTEGER,
konzern_id INTEGER DEFAULT 0 NOT NULL,
werk_id INTEGER DEFAULT - 1 NOT NULL,
bis_relevant_fg INTEGER DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);