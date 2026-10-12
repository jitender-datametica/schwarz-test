CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.hwg_per_2 (
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
hwg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Hauptwarengruppe'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
dat_von DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
dat_bis DATE OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
abt_id BIGNUMERIC(38,0)
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
hr_objekt_bereich_id BIGNUMERIC(38,0)
OPTIONS(description='ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz)'),
hr_objekt_bereich_id_de BIGNUMERIC(38,0)
OPTIONS(description='ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz) für DE'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='EK-INTEGER  - Hauptwarengruppen -  Stufe in der Artikelhierarchie');