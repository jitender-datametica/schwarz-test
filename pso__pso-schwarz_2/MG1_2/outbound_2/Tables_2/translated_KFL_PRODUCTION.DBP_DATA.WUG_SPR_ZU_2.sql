CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.WUG_SPR_ZU_2 (
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
WG_ID INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
WUG_ID INTEGER NOT NULL OPTIONS(description='ID der Warenuntergruppe'),
WUG_BEZ STRING(160) COLLATE 'und:ci' OPTIONS(description='Warenuntergruppe - Bezeichnung'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
) OPTIONS(description='TP2_AIS - Sprachabhaengige Bezeichnungen der Warenuntergruppen');