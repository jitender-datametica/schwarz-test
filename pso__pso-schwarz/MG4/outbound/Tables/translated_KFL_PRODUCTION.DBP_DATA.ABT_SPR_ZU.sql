CREATE OR REPLACE TABLE kfl_production_dbp_data.abt_spr_zu (
abt_id INTEGER NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
arthiertyp_id INTEGER NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet z. Bsp., ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
abt_bez STRING(400) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Abteilung'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='VIS - Abteilung - Sprachen  - Zuordnung ');