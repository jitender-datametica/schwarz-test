CREATE OR REPLACE TABLE kfl_production_dbp_etl.owg_per_tmp_2 (
owg_id INTEGER NOT NULL OPTIONS(description='ID der Oberwarengruppe'),
arthiertyp_id INTEGER NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
dat_von DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
dat_bis DATE OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
hwg_id INTEGER OPTIONS(description='ID der Hauptwarengruppe'),
hr_objekt_bereich_id INTEGER
OPTIONS(description='ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz) INTEGER Sicht'),
hr_objekt_bereich_id_de INTEGER
OPTIONS(description='ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz) DE Sicht'),
td_update TIMESTAMP,
td_insert TIMESTAMP
);