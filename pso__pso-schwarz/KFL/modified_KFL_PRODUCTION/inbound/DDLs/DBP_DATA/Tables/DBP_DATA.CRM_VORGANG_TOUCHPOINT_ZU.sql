--==============================================================
-- Table: crm_vorgang_touchpoint_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_vorgang_touchpoint_zu
   generated from Powerdesigner on Dienstag, 18. Oktober 2022 11:05:11
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_VORGANG_TOUCHPOINT_ZU (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH.',
   crm_vorgang_id                      VARCHAR(36)     NOT NULL COMMENT 'Ticket-ID.',
   touchpoint_id                       INTEGER    NOT NULL COMMENT 'Several count-fields that describe the amount of times that the ticket has been in each touchpoint (department, customer, store etc.).',
   touchpoint_count                    INTEGER    COMMENT 'Several count-fields that describe the amount of times that the ticket has been in each touchpoint (department, customer, store etc.).',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_VORGANG_TOUCHPOINT_ZU PRIMARY KEY (crm_vorgang_id, touchpoint_id, mandant_id) NOT ENFORCED
)  COMMENT = 'Assignment of respective touchpoints (touchpoints are departments the ticket gets sent to during the solution process) to ticket number, including counts.';
