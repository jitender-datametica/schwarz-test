--==============================================================
-- Table: t_dim_site_status_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_site_status_1
   generated from Powerdesigner on Dienstag, 2. April 2024 06:38:06
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_SITE_STATUS_1 (
   site_status_cd                      VARCHAR(20)      NOT NULL COMMENT 'The code for the status_1 of the site.',
   site_status_descr                   VARCHAR(100)     NOT NULL COMMENT 'A textual description for the site_status_cd written out in group language (German).',
   site_status_descr_de                VARCHAR(100)     COMMENT 'A textual description for the site_status_cd written out in German.',
   site_status_descr_en                VARCHAR(100)     COMMENT 'A textual description for the site_status_cd written out in English.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_SITE_STATUS PRIMARY KEY (site_status_cd) NOT ENFORCED 
)  COMMENT = 'This dimension tracks the lifecycle status_1 of a site. E.g. a site can be active or deleted.';

