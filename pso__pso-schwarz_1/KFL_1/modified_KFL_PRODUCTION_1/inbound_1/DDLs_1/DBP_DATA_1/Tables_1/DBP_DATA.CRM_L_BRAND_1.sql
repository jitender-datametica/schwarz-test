--==============================================================
-- Table: crm_l_brand_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_brand_1
   generated from Powerdesigner on Friday, June 24, 2022 1:03:36 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_BRAND_1 (
   crm_brand_id                        VARCHAR(36)     NOT NULL COMMENT 'ID of brand_1 the customer has a complain abou',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_BRAND PRIMARY KEY (crm_brand_id) NOT ENFORCED
)  COMMENT = 'Lookup for brand_1 surrogate keys (= brand_1 the customer has a complain about)';
