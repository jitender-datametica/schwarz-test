CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ABT_SPR_ZU_1 (
ABT_ID INTEGER NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet z. Bsp., ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
ABT_BEZ STRING(400) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Abteilung'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
) OPTIONS(description='VIS - Abteilung - Sprachen  - Zuordnung ');