--==============================================================
-- Table: geku_emotion_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_emotion_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_EMOTION_SPR_ZU_2 (
   geku_emotion_id                     INTEGER     NOT NULL COMMENT 'eindeutige ID der Emotion',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
   geku_emotion_bez                    VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Emotion (lob, Kritik,etc)',
   quelle_spr_id                       INTEGER     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_EMOTION_SPR_ZU PRIMARY KEY (geku_emotion_id, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Sprachabhängige Bezeichnungen der Emotions';

