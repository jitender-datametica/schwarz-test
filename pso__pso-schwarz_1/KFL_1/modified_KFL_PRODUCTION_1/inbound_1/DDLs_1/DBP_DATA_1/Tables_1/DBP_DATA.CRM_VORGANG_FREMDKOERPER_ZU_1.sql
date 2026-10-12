--==============================================================
-- Table: crm_vorgang_fremdkoerper_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_vorgang_fremdkoerper_zu_1
   generated from Powerdesigner on Wednesday, July 20, 2022 10:31:04 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_VORGANG_FREMDKOERPER_ZU_1 (
   crm_vorgang_id                      VARCHAR(36)     COLLATE 'en-ci' DEFAULT '-1' NOT NULL COMMENT 'Vorgang ID (GUID) aus CRM',
   crm_fremdkoerper_id                 INTEGER    DEFAULT -1 NOT NULL COMMENT 'Art_1 der Verunreinigung ID',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_VORGANG_FREMDKOERPER_ZU PRIMARY KEY (crm_vorgang_id, crm_fremdkoerper_id) NOT ENFORCED
)  COMMENT = 'A relationship table that links crm_vorgang_1 and crm_l_fremdkoerper_1';
