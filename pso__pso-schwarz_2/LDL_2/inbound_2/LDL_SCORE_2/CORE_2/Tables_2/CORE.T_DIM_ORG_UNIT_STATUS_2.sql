--==============================================================
-- Table: t_dim_org_unit_status_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_org_unit_status_2
   generated from Powerdesigner on Donnerstag, 16. November 2023 09:35:58
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_ORG_UNIT_STATUS_2 (
   org_unit_status_cd                  VARCHAR(20)     NOT NULL COMMENT 'The code for the status_2 of the org unit.',
   org_unit_status_descr               VARCHAR(100)    NOT NULL COMMENT 'A textual description for the org_unit_status_cd written out in group language (German).',
   org_unit_status_descr_de            VARCHAR(100)    COMMENT 'A textual description for the org_unit_status_cd written out in German.',
   org_unit_status_descr_en            VARCHAR(100)    COMMENT 'A textual description for the org_unit_status_cd written out in English.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_ORG_UNIT_STATUS PRIMARY KEY (org_unit_status_cd) NOT ENFORCED 
)  COMMENT = 'This dimension tracks the lifecycle status_2 of a org unit. E.g. a site can be active or deleted.';
