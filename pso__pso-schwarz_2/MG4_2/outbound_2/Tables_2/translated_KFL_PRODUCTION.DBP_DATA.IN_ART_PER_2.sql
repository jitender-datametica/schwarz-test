CREATE OR REPLACE TABLE kfl_production_dbp_data.in_art_per_2 (
mandant_id INTEGER NOT NULL,
in_art_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL,
aktiv_fg INTEGER DEFAULT 1 NOT NULL,
katalog_fg INTEGER DEFAULT 0 NOT NULL,
einkauf_prueft_fg INTEGER DEFAULT 0 NOT NULL,
normalposition_fg INTEGER DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);