CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.HWG_SPR_ZU (
HWG_ID INTEGER NOT NULL OPTIONS(description='ID der Hauptwarengruppe'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
HWG_BEZ STRING(400) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung der Hauptwarengruppe'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
)
OPTIONS(description='EK-INTEGER - Sprachabhängige Bezeichnung der Hauptwarengruppen -  Stufe in der Artikelhierarchie');