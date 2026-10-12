CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.WBL (
WBL_ID INTEGER NOT NULL OPTIONS(description='Warenbereichsleiter ID'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
WBL_DAT_VON DATE OPTIONS(description='Gültig-ab Datum des Warenbereichsleiters'),
WBL_NAME STRING(160) COLLATE 'und:ci' OPTIONS(description='Name des Warenbereichsleiters'),
GF_ID INTEGER OPTIONS(description='Geschäftsführer ID'),
EK_FG INTEGER NOT NULL
OPTIONS(description='Kennzeichnet, ob es sich um einen dem Einkauf zugehörigen Mitarbeiter handelt'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
) OPTIONS(description='VIS - Warenbereichsleiter ');