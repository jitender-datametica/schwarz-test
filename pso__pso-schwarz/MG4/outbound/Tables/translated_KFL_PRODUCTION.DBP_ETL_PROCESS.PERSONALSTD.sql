CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.personalstd (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id INTEGER NOT NULL OPTIONS(description='Marktnummer'),
nb_id INTEGER NOT NULL OPTIONS(description='Nummer des Nebenbetriebs'),
kjmo INTEGER NOT NULL OPTIONS(description='Kalenderjahresmonat'),
stunden_ist NUMERIC(9,2) NOT NULL OPTIONS(description='Iststunden'),
stunden_plan INTEGER NOT NULL OPTIONS(description='Planstunden als genzzahliger Wert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);