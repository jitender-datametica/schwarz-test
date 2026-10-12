CREATE OR REPLACE TABLE kfl_production_dbp_etl.resolved_articles (
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
lief_beleg_id INTEGER NOT NULL,
lief_beleg_pos_id INTEGER NOT NULL,
dat_lief_soll DATE NOT NULL,
mutter_art_id INTEGER NOT NULL,
final_art_id INTEGER NOT NULL,
dat_haltbarkeit DATE,
kunde_id STRING(10) NOT NULL,
lief_typ_id STRING(4) NOT NULL
);

