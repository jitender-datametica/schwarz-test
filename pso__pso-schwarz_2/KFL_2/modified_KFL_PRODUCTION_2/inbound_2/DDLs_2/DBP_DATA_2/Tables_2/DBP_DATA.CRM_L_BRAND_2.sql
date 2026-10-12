--==============================================================
-- Table: crm_l_brand_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_brand_2
   generated from Powerdesigner on Friday, June 24, 2022 1:03:36 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_BRAND_2 (
   crm_brand_id                        VARCHAR(36)     NOT NULL COMMENT 'ID of brand_2 the customer has a complain abou',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_BRAND PRIMARY KEY (crm_brand_id) NOT ENFORCED
)  COMMENT = 'Lookup for brand_2 surrogate keys (= brand_2 the customer has a complain about)';
