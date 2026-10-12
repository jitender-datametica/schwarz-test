CREATE OR REPLACE TABLE kfl_production_dbp_etl.as_food_final (
art_id INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
dat_auslistung DATE NOT NULL,
gp_id INTEGER DEFAULT - 1 NOT NULL,
phase_status INTEGER DEFAULT - 1 NOT NULL,
erl_fg INTEGER DEFAULT 0 NOT NULL,
dat_final DATE,
menge_startbestand NUMERIC(18,3) DEFAULT 0 NOT NULL,
vk_netto NUMERIC(18,4) DEFAULT 0 NOT NULL,
menge_endbestand NUMERIC(18,3) DEFAULT 0 NOT NULL,
erl_kz STRING(1) COLLATE 'und:ci' DEFAULT '' NOT NULL,
dat_aend DATE,
wrg_id STRING(3)
);