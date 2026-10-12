--==============================================================
-- Table: crm_l_magicword_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_magicword_1
   generated from Powerdesigner on Friday, June 24, 2022 1:02:13 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_MAGICWORD_1 (
   crm_magicword_id                    VARCHAR(36)     NOT NULL COMMENT 'Topic related to the content of the ticket which had been defined by the business',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_MAGICWORD PRIMARY KEY (crm_magicword_id) NOT ENFORCED
)  COMMENT = 'Lookup for magic word surrogate keys (= "Zauberwort" = topic category tag_1 for CRM tickets)';
