CREATE OR REPLACE TABLE kfl_production_dbp_data.owg_per (
owg_id INTEGER NOT NULL OPTIONS(description='ID der Oberwarengruppe'),
arthiertyp_id INTEGER NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
dat_von DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT'),
dat_bis DATE OPTIONS(description='Datum im Format JJJJ-MM-TT'),
hwg_id INTEGER OPTIONS(description='ID der Hauptwarengruppe'),
hr_objekt_bereich_id INTEGER
OPTIONS(description='ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz) INTEGER Sicht'),
hr_objekt_bereich_id_de INTEGER
OPTIONS(description='ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz) DE Sicht'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='EK-INTEGER  - Oberwarengruppen -  Stufe in der Artikelhierarchie');