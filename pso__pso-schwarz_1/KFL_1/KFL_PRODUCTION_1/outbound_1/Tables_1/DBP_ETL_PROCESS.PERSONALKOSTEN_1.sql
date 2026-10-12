CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.personalkosten_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahresmonat'),
kosten_ist NUMERIC(18,4) NOT NULL,
abgr_fg BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);