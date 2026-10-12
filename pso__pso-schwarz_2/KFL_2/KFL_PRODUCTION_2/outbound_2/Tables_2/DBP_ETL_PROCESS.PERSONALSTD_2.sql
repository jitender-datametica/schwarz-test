CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.personalstd_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des Nebenbetriebs'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahresmonat'),
stunden_ist NUMERIC(9,2) NOT NULL OPTIONS(description='Iststunden'),
stunden_plan BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Planstunden als genzzahliger Wert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);