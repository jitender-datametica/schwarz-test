--==============================================================
-- Table: t_ref_organization_unit_type_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_organization_unit_type_1
   generated from Powerdesigner on Mittwoch, 7. August 2024 16:21:15
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REF_ORGANIZATION_UNIT_TYPE_1 (
   org_unit_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the organization unit_1 (e.g. regional or country_1 subsidiary).',
   org_unit_type_descr                 VARCHAR(100)    NOT NULL COMMENT 'A textual description for the org_unit_type_cd written out in group language (German).',
   org_unit_type_descr_de              VARCHAR(100)    COMMENT 'A textual description for the org_unit_type_cd written out in German.',
   org_unit_type_descr_en              VARCHAR(100)    COMMENT 'A textual description for the org_unit_type_cd written out in English.',
   elm_org_unit_type_id                NUMBER          COMMENT 'The code for the type of the organization unit_1, as defined in the source system. (locationtypeid)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_ORGANIZATION_UNIT_TYPE PRIMARY KEY (org_unit_type_cd) NOT ENFORCED 
)  COMMENT = 'Describes to which type an organization belongs to. INT = Stiftung, DL = Dienstleistung, RG = Regionalgesellschaft. Goods that are delivered to the last warehouses in order to transport those to the Lidl stores, are transported to the RG units. All three types refere to (interne Organisationseinheit).';
