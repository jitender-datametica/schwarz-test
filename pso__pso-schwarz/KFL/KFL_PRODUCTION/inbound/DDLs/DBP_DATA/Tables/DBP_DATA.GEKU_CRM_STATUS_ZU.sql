--==============================================================
-- Table: geku_crm_status_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_crm_status_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_CRM_STATUS_ZU (
   geku_crm_status_id                  NUMBER(38,0)     NOT NULL COMMENT 'GEKU - Mapping ID',
   geku_status_id                      NUMBER(38,0)     COMMENT 'eindeutige ID des Ticketstatus (erledigt, eskaliert, in Arbeit, überfällig)',
   crm_status_id                       NUMBER(38,0)     COMMENT 'Ticket Status ID z. B. Abgeschlossen',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_CRM_STATUS_ZU PRIMARY KEY (geku_crm_status_id) NOT ENFORCED
)  COMMENT = 'GEKU - Mapping Tabelle Status Geku zu CRM';

