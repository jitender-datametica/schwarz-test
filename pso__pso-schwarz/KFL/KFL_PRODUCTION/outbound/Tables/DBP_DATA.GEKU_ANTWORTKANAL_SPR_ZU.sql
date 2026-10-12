--==============================================================
-- Table: geku_antwortkanal_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_antwortkanal_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_antwortkanal_spr_zu (
geku_antwortkanal_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Antwortkanals, z.Bsp. 100661 aus answer_channel_uid'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
geku_antwortkanal_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Antwortkanals, z.Bsp. E-Mail'),
quelle_spr_id BIGNUMERIC(38,0)
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_antwortkanal_id, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Sprachabhängige Bezeichnungen der Antwortkanäle');