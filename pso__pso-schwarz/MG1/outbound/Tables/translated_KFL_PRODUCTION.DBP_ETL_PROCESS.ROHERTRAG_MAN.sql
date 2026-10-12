CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ETL_PROCESS.ROHERTRAG_MAN (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
KJMO INTEGER NOT NULL OPTIONS(description='Kalenderjahresmonat'),
ROHERTRAG_IST NUMERIC(18,4) NOT NULL,
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);