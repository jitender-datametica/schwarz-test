CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ETL_PROCESS.ART_MATNR_CHAR_MAPPING_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
KL_ART_ID INTEGER NOT NULL
OPTIONS(description='7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer'),
MATNR_CHAR STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Alphanummerisch Artikelnummer aus dem Quellsystem (matnr)'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);