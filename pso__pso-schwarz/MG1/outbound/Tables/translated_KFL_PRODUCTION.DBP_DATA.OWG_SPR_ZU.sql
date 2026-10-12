CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.OWG_SPR_ZU (
OWG_ID INTEGER NOT NULL OPTIONS(description='ID der Oberwarengruppe'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
OWG_BEZ STRING(400) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung der Oberwarengruppe'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
) OPTIONS(description='EK-INTEGER - Sprachabhängige Bezeichnung der Oberwarengruppen -  Stufe in der Artikelhierarchie');