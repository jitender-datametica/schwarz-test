--==============================================================
-- Table: crm_l_emotion_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_emotion_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_EMOTION_2 (
   crm_emotion_id                      INTEGER     NOT NULL COMMENT 'Emotion ID (GUID) aus CRM',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_EMOTION PRIMARY KEY (crm_emotion_id) NOT ENFORCED
)  COMMENT = 'KMR - Enthält die möglichen Bewertungen der Kundenzufriedentheit aus der CRM Entität kl_emotion - MS Dynamics CRM';

