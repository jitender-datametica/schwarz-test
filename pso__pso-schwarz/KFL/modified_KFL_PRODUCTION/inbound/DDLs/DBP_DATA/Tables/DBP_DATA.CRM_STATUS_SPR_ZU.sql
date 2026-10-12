--==============================================================
-- Table: crm_status_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_status_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_STATUS_SPR_ZU (
   crm_status_id                       INTEGER     NOT NULL COMMENT 'Ticket Status ID z. B. Abgeschlossen',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   crm_status_bez                      VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Status Bezeichnung DWH generiert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_STATUS_SPR_ZU PRIMARY KEY (crm_status_id, spr_id) NOT ENFORCED
)  COMMENT = 'KMR - Sprachzuordnungstabelle Statuscode - MS Dynamics CRM';

