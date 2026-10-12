--==============================================================
-- Table: crm_l_brand
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_brand
   generated from Powerdesigner on Friday, June 24, 2022 1:03:36 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_BRAND (
   crm_brand_id                        VARCHAR(36)     NOT NULL COMMENT 'ID of brand the customer has a complain abou',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_BRAND PRIMARY KEY (crm_brand_id) NOT ENFORCED
)  COMMENT = 'Lookup for brand surrogate keys (= brand the customer has a complain about)';
