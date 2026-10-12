CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abt_spr_zu_2 (
abt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z. Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
abt_bez STRING(400) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Abteilung'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='VIS - Abteilung - Sprachen  - Zuordnung ');