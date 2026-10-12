CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ETL.WUG_SPR_ZU_TEMP_1 (
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
WG_ID INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
WUG_ID INTEGER NOT NULL OPTIONS(description='ID der Warenuntergruppe'),
WUG_BEZ STRING(160) COLLATE 'und:ci' OPTIONS(description='Warenuntergruppe - Bezeichnung'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
);