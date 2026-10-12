--==============================================================
-- Table: crm_emotion_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_emotion_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_EMOTION_SPR_ZU (
   crm_emotion_id                      INTEGER     NOT NULL COMMENT 'Emotion ID (GUID) aus CRM',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   emotion_bez                         VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'Emotion text',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_EMOTION_SPR_ZU PRIMARY KEY (crm_emotion_id, spr_id) NOT ENFORCED
)  COMMENT = 'KMR - Enthält die möglichen Bewertungen der Kundenzufriedentheit aus der CRM Entität kl_emotion - MS Dynamics CRM';

