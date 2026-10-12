--==============================================================
-- Table: crm_l_status_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_status_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_STATUS_1 (
   crm_status_id                       INTEGER     NOT NULL COMMENT 'Ticket Status_1 ID z. B. Abgeschlossen',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_STATUS PRIMARY KEY (crm_status_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup für den Vorgangsstatus - MS Dynamics CRM';

