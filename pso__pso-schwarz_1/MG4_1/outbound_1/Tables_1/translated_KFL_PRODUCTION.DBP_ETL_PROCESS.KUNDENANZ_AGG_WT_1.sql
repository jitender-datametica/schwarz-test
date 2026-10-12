CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.kundenanz_agg_wt_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat DATE,
calc_fg INTEGER,
dat_lief DATE,
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);