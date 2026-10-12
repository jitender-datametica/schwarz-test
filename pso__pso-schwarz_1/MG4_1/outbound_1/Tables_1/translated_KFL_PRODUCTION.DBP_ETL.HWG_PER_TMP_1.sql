CREATE OR REPLACE TABLE kfl_production_dbp_etl.hwg_per_tmp_1 (
arthiertyp_id INTEGER NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
hwg_id INTEGER NOT NULL OPTIONS(description='ID der Hauptwarengruppe'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
dat_von DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
dat_bis DATE OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
abt_id INTEGER
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
hr_objekt_bereich_id INTEGER
OPTIONS(description='ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz)'),
hr_objekt_bereich_id_de INTEGER
OPTIONS(description='ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz) für DE'),
td_update TIMESTAMP,
td_insert TIMESTAMP
);