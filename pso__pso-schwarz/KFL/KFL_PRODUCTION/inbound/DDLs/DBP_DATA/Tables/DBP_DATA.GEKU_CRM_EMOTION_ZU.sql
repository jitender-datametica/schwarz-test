--==============================================================
-- Table: geku_crm_emotion_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_crm_emotion_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_CRM_EMOTION_ZU (
   geku_crm_emotion_id                 NUMBER(38,0)     NOT NULL COMMENT 'Mapping ID',
   geku_emotion_id                     NUMBER(38,0)     COMMENT 'eindeutige ID der Emotion',
   crm_emotion_id                      NUMBER(38,0)     COMMENT 'Emotion ID (GUID) aus CRM',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_CRM_EMOTION_ZU PRIMARY KEY (geku_crm_emotion_id) NOT ENFORCED
)  COMMENT = 'Mapping Tabelle Geku CRM für Emotionen';

