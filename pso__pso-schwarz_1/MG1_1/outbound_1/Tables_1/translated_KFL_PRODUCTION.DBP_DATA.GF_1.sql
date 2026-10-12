CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.GF_1 (
GF_ID INTEGER NOT NULL OPTIONS(description='Geschäftsführer ID, numerisch'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
EK_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Kennzeichnet, ob es sich um einen dem Einkauf zugehörigen Mitarbeiter handelt'),
GF_NAME STRING(160) COLLATE 'und:ci' OPTIONS(description='Name des Geschäftsführers'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
) OPTIONS(description='VIS - Lookup Tabelle  Geschäftsführer');