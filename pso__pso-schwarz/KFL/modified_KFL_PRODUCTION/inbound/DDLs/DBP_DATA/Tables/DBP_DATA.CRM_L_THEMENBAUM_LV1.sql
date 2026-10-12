--==============================================================
-- Table: crm_l_themenbaum_lv1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_themenbaum_lv1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_THEMENBAUM_LV1 (
   crm_themenbaum_lv1_id               VARCHAR(36)      NOT NULL COLLATE 'en-ci' COMMENT 'Themenbaum Level 1 Id',
   NAME                                VARCHAR(70)      COLLATE 'en-ci' COMMENT 'Name des aktuellen Themnbaumlevels',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_THEMENBAUM_LV1 PRIMARY KEY (crm_themenbaum_lv1_id) NOT ENFORCED
)  COMMENT = 'KMR - Enthält Themenabumeiträge der Ebene 1 - MS Dynamics CRM';

