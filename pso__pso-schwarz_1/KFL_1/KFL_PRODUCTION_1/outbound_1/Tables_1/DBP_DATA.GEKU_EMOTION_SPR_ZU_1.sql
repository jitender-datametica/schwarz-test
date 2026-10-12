--==============================================================
-- Table: geku_emotion_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_emotion_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_emotion_spr_zu_1 (
geku_emotion_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='eindeutige ID der Emotion'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.'),
geku_emotion_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Emotion (lob, Kritik,etc)'),
quelle_spr_id BIGNUMERIC(38,0)
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_emotion_id, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Sprachabhängige Bezeichnungen der Emotions');