--==============================================================
-- Table: crm_prioritaet_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_prioritaet_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_PRIORITAET_SPR_ZU_1 (
   crm_prioritaet_id                   INTEGER     NOT NULL COMMENT 'ID der Priorität, niedrig, mittel, hoch',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   crm_prioritaet_bez                  VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Priorität Bezeichnung DWH generiert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_PRIORITAET_SPR_ZU PRIMARY KEY (crm_prioritaet_id, spr_id) NOT ENFORCED
)  COMMENT = 'KMR - Sprachzuordnungstabelle Priorität - MS Dynamics CRM';

