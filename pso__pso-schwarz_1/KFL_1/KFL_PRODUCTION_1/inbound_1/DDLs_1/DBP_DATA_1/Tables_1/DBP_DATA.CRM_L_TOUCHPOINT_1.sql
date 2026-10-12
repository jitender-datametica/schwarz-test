--==============================================================
-- Table: crm_l_touchpoint_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_touchpoint_1
   generated from Powerdesigner on Dienstag, 18. Oktober 2022 09:46:08
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_TOUCHPOINT_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH.',
   touchpoint_id                       NUMBER(38,0)    NOT NULL COMMENT 'Several count-fields that describe the amount of times that the ticket has been in each touchpoint (department, customer, store etc.).',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_TOUCHPOINT PRIMARY KEY (mandant_id, touchpoint_id) NOT ENFORCED
)  COMMENT = 'Lookup for touchpoints (touchpoints are departments the ticket gets sent to during the solution process).';
