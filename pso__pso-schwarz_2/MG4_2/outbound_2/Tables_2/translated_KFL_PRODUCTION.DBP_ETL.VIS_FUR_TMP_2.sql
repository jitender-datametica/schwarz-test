CREATE OR REPLACE TABLE kfl_production_dbp_etl.vis_fur_tmp_2 (
mandant_id INTEGER NOT NULL,
art_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
dat DATE NOT NULL,
menge_fur_mean NUMERIC(18,3) NOT NULL,
menge_fur_max NUMERIC(18,3) NOT NULL,
menge_fur_aktion NUMERIC(18,3) NOT NULL
);