--==============================================================
-- Table: crm_touchpoint_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_touchpoint_spr_zu
   generated from Powerdesigner on Dienstag, 18. Oktober 2022 11:07:59
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_TOUCHPOINT_SPR_ZU (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH.',
   touchpoint_id                       INTEGER    NOT NULL COMMENT 'Several count-fields that describe the amount of times that the ticket has been in each touchpoint (department, customer, store etc.).',
   spr_id                              INTEGER    NOT NULL COMMENT 'Language ID.',
   touchpoint_bez                      VARCHAR(80)     COMMENT 'Description of each touchpoint ID.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_TOUCHPOINT_SPR_ZU PRIMARY KEY (touchpoint_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'spr_zu-table for touchpoints (touchpoints are departments the ticket gets sent to during the solution process).';
