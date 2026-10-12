CREATE OR REPLACE TABLE kfl_production_dbp_etl.bon_agg_kassenberichte_tmp_1 (
bon_id STRING(25) NOT NULL,
bon_dat DATE NOT NULL,
wup_id INTEGER NOT NULL,
wrg_id STRING(3) NOT NULL,
mandant_id INTEGER NOT NULL,
kassensystem_name STRING(10),
kasse_nr INTEGER NOT NULL,
xml_name STRING(255)
);