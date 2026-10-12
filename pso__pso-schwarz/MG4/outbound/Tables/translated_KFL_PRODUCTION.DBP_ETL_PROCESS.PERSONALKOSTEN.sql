CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.personalkosten (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
kjmo INTEGER NOT NULL OPTIONS(description='Kalenderjahresmonat'),
kosten_ist NUMERIC(18,4) NOT NULL,
abgr_fg INTEGER NOT NULL,
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);