CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.HWG_SPR_ZU_1 (
HWG_ID INTEGER NOT NULL OPTIONS(description='ID der Hauptwarengruppe'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
HWG_BEZ STRING(400) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung der Hauptwarengruppe'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
)
OPTIONS(description='EK-INTEGER - Sprachabhängige Bezeichnung der Hauptwarengruppen -  Stufe in der Artikelhierarchie');