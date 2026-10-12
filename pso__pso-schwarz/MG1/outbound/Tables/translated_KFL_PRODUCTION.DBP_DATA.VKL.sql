CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.VKL (
VKL_ID INTEGER NOT NULL OPTIONS(description='ID des Verkaufsleiters'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
GF_ID INTEGER NOT NULL OPTIONS(description='Geschäftsführer ID, numerisch'),
VKL_NAME STRING(320) OPTIONS(description='Name des Verkaufsleiters'),
TD_INSERT TIMESTAMP,
TD_UPDATE TIMESTAMP
) OPTIONS(description='VIS - Lookup Tabelle Verkaufsleiter');