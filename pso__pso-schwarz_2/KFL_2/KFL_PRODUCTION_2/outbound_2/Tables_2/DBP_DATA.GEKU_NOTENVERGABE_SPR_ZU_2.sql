--==============================================================
-- Table: geku_notenvergabe_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_notenvergabe_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_notenvergabe_spr_zu_2 (
geku_notenvergabe_durch_id INTEGER NOT NULL OPTIONS(description='ID der Notenvergeber'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.'),
geku_notenvergabe_durch_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Notenvergebers, z.Bsp "MZK1 Überschrieben"'),
quelle_spr_id BIGNUMERIC(38,0)
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_notenvergabe_durch_id, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Sprachabhängige Bezeichnungen der Notenvergeber aus geku_text');