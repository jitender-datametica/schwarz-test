CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.HWG_PER_2 (
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
HWG_ID INTEGER NOT NULL OPTIONS(description='ID der Hauptwarengruppe'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
DAT_VON DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
DAT_BIS DATE OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
ABT_ID INTEGER
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
HR_OBJEKT_BEREICH_ID INTEGER
OPTIONS(description='ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz)'),
HR_OBJEKT_BEREICH_ID_DE INTEGER
OPTIONS(description='ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz) für DE'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
) OPTIONS(description='EK-INTEGER - Hauptwarengruppen -  Stufe in der Artikelhierarchie');