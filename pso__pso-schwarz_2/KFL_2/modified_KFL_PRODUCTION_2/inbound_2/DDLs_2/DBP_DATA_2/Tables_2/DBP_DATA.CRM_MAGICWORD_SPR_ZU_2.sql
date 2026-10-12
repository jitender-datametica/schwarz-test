--==============================================================
-- Table: crm_magicword_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_magicword_spr_zu_2
   generated from Powerdesigner on Friday, June 24, 2022 1:05:45 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_MAGICWORD_SPR_ZU_2 (
   crm_magicword_id                    VARCHAR(36)     NOT NULL COMMENT 'Topic related to the content of the ticket which had been defined by the business',
   mandant_id                          INTEGER    NOT NULL COMMENT 'country_2 ID',
   spr_id                              INTEGER    NOT NULL COMMENT 'language ID',
   crm_magicword_bez                   VARCHAR(100)    COMMENT 'description of the magic word',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_MAGICWORD_SPR_ZU PRIMARY KEY (crm_magicword_id, mandant_id, spr_id) NOT ENFORCED
)  COMMENT = 'Spr_zu für magic word surrogate keys (= "Zauberwort" = topic category tag_2 for CRM tickets)';
