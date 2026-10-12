--==============================================================
-- Table: t_ref_org_unit_status_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_org_unit_status_1
   generated from Powerdesigner on Donnerstag, 16. November 2023 09:33:00
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REF_ORG_UNIT_STATUS_1 (
   org_unit_status_cd                  VARCHAR(20)     NOT NULL COMMENT 'The code for the status_1 of the org unit.',
   org_unit_status_descr               VARCHAR(100)    NOT NULL COMMENT 'A textual description for the org_unit_status_cd written out in group language (German).',
   org_unit_status_descr_de            VARCHAR(100)    COMMENT 'A textual description for the org_unit_status_cd written out in German.',
   org_unit_status_descr_en            VARCHAR(100)    COMMENT 'A textual description for the org_unit_status_cd written out in English.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_ORG_UNIT_STATUS PRIMARY KEY (org_unit_status_cd) NOT ENFORCED 
)  COMMENT = 'This entity tracks the lifecycle status_1 of a org unit. E.g. a site can be active or deleted.';
