--==============================================================
-- Table: crm_prozess_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_prozess_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_PROZESS_SPR_ZU (
   crm_prozess_id                      INTEGER     NOT NULL COMMENT 'Prozess ID (GUID) aus CRM - oberste Stuffe der Hierarchie',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   prozess_bez                         VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Prozesses aus CRM',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_PROZESS_SPR_ZU PRIMARY KEY (crm_prozess_id, spr_id) NOT ENFORCED
)  COMMENT = 'KMR - Oberste Ebene der CRM Hierarchie - MS Dynamics CRM';

