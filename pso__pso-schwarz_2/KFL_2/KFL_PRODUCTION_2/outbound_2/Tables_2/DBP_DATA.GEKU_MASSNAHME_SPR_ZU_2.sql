--==============================================================
-- Table: geku_massnahme_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_massnahme_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_massnahme_spr_zu_2 (
geku_massnahme_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID einer GeKu-Massnahme aus measure_uid'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.'),
geku_massnahme_bez STRING(250) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Massnahme aus code_name'),
quelle_spr_id BIGNUMERIC(38,0)
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_massnahme_uid, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Bezeichnung der Massnahmen aus s1_dwh_text_out');