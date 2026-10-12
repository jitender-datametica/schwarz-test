--==============================================================
-- Table: t_ref_party_type_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_party_type_1
   generated from Powerdesigner on Mittwoch, 7. August 2024 16:22:04
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REF_PARTY_TYPE_1 (
   party_type_cd                       VARCHAR(20)     NOT NULL COMMENT 'The code for the type of party e.g. company, organization, person etc.',
   party_type_descr                    VARCHAR(100)    NOT NULL COMMENT 'A textual description for the party_type_cd written out in group language (German).',
   party_type_descr_de                 VARCHAR(100)    COMMENT 'A textual description for the party_type_cd written outin German.',
   party_type_descr_en                 VARCHAR(100)    COMMENT 'A textual description for the party_type_cd written out in English.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_PARTY_TYPE PRIMARY KEY (party_type_cd) NOT ENFORCED 
)  COMMENT = 'Describes whether a party is a company (Unternehmen), organization unit_1 (Organisationseinheit) or a person. Those types refere to the party. ';
