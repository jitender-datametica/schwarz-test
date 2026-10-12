CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ETL.OWG_PER_TMP_1 (
OWG_ID INTEGER NOT NULL OPTIONS(description='ID der Oberwarengruppe'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
DAT_VON DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
DAT_BIS DATE OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
HWG_ID INTEGER OPTIONS(description='ID der Hauptwarengruppe'),
HR_OBJEKT_BEREICH_ID INTEGER
OPTIONS(description='ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz) INTEGERSicht'),
HR_OBJEKT_BEREICH_ID_DE INTEGER
OPTIONS(description='ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz) DE Sicht'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
);