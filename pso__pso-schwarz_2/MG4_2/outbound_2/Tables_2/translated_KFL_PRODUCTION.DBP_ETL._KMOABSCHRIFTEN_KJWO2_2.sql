CREATE OR REPLACE TABLE kfl_production_dbp_etl.`_kmoabschriften_kjwo2_2` (
kjwo INTEGER,
mandant_id INTEGER,
wup_id INTEGER,
nb_id INTEGER,
art_id INTEGER,
dat_auslistung DATE,
wrg_id STRING(3) COLLATE 'und:ci',
menge_abschrift_122 NUMERIC(29,3),
abschriftbetrag_netto_122 NUMERIC(29,2)
);