--==============================================================
-- Table: crm_brand_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_brand_spr_zu
   generated from Powerdesigner on Friday, June 24, 2022 1:04:31 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_BRAND_SPR_ZU (
   crm_brand_id                        VARCHAR(36)     NOT NULL COMMENT 'ID of brand the customer has a complain abou',
   mandant_id                          INTEGER    NOT NULL COMMENT 'country ID',
   spr_id                              INTEGER    NOT NULL COMMENT 'language ID',
   crm_brand_bez                       VARCHAR(100)    COMMENT 'description of the brand',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_BRAND_SPR_ZU PRIMARY KEY (crm_brand_id, mandant_id, spr_id) NOT ENFORCED
)  COMMENT = 'Spr_zu for brand surrogate keys (= brand the customer has a complain about)';
