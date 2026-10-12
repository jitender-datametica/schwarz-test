--==============================================================
-- Table: crm_l_prozess_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_prozess_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_PROZESS_2 (
   crm_prozess_id                      INTEGER     NOT NULL COMMENT 'Prozess ID (GUID) aus CRM - oberste Stuffe der Hierarchie',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_PROZESS PRIMARY KEY (crm_prozess_id) NOT ENFORCED
)  COMMENT = 'KMR - Oberste Ebene der CRM Hierarchie - MS Dynamics CRM';

