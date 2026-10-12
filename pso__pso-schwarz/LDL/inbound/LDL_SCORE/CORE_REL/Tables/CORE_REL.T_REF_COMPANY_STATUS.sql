--==============================================================
-- Table: t_ref_company_status
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_company_status
   generated from Powerdesigner on Donnerstag, 16. November 2023 09:34:18
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REF_COMPANY_STATUS (
   company_status_cd                   VARCHAR(20)     NOT NULL COMMENT 'The code for the status of the company. (column  will likely be deleted and table doesn''t exist on SF)',
   company_status_descr                VARCHAR(100)    NOT NULL COMMENT 'A textual description for the company_status_cd written out in group language (column  will likely be deleted and table doesn''t exist on SF)',
   company_status_descr_de             VARCHAR(100)    COMMENT 'A textual description for the company_status_cd written out in German. (column  will likely be deleted and table doesn''t exist on SF)',
   company_status_descr_en             VARCHAR(100)    COMMENT 'A textual description for the company_status_cd written out in English. (column  will likely be deleted and table doesn''t exist on SF)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_COMPANY_STATUS PRIMARY KEY (company_status_cd) NOT ENFORCED 
)  COMMENT = 'The current status of a company';
