CREATE TABLE CORE_REL_OCTOPUS.T_REF_SITE_OPEN_STATUS_TYPE_1 (
   site_open_status_type_cd            VARCHAR(20)     NOT NULL COMMENT 'Code for the opening status_1 of the site (crossdock). ',
   site_open_status_type_descr         VARCHAR(100)    NOT NULL COMMENT 'Description of the site_open_status_type_cd in group language.',
   site_open_status_type_descr_de      VARCHAR(100)    COMMENT 'A textual description of site_open_status_type_cd (written out) in German.',
   site_open_status_type_descr_en      VARCHAR(100)    COMMENT 'A textual description of site_open_status_type_cd (written out) in group language English.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_SITE_OPEN_STATUS_TYPE PRIMARY KEY (site_open_status_type_cd) NOT ENFORCED 
)  COMMENT = 'This minor entity defines the opening status_1 of the site (crossdock). Such as ''opened'', ''closed'' or ''partly opened''. ';
