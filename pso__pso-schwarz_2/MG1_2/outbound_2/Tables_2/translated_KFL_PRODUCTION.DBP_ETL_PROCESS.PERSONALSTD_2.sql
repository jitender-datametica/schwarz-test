CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ETL_PROCESS.PERSONALSTD_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Marktnummer'),
NB_ID INTEGER NOT NULL OPTIONS(description='Nummer des Nebenbetriebs'),
KJMO INTEGER NOT NULL OPTIONS(description='Kalenderjahresmonat'),
STUNDEN_IST NUMERIC(9,2) NOT NULL OPTIONS(description='Iststunden'),
STUNDEN_PLAN INTEGER NOT NULL OPTIONS(description='Planstunden als genzzahliger Wert'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);