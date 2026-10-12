CREATE OR REPLACE TABLE kfl_production_dbp_etl.ind_subkategorie (
mandant_id INTEGER,
in_objekt_nr STRING(10),
kategorie STRING(60) COLLATE 'und:ci',
kategorie_id INTEGER,
spr_id INTEGER,
kategorie_bez STRING(80) COLLATE 'und:ci'
);