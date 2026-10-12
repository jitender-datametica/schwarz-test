CREATE TABLE CORE_REL_OCTOPUS.T_ORG_UNIT_2 (
   org_unit_sid                        NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the organization unit.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   parent_org_unit_sid                 NUMBER          COMMENT 'unique identifier (surrogate key) of the organization unit_2 that is parent for the organization unit_2',
   org_unit_type_cd                    VARCHAR(20)     COMMENT 'The code for the type of the organization unit_2 (e.g. regional or country_2 subsidiary).',
   org_unit_nr                         VARCHAR(20)     COMMENT 'A numeric or alphanumeric value which identifies the organization unit_2 for the business.',
   org_unit_name                       VARCHAR(100)    NOT NULL COMMENT 'The name by which the organization unit_2 is known.',
   org_unit_short_name                 VARCHAR(100)    COMMENT 'Short name for thjois organisation unit_2',
   org_unit_status_cd                  VARCHAR(20)     COMMENT 'The code for the status_2 of the unit_2 org (column  will likely be deleted and table doesn''t exist on SF)',
   is_onlineshop_fg                    BOOLEAN         COMMENT 'Is this an online shop?',
   is_internal_contract_partner_fg     BOOLEAN         COMMENT 'Is organizations acting as contractual partners for logistics agreements ?',
   vat_nr                              VARCHAR(20)     COMMENT 'The vat number (Umsatzsteuer ID).',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_ORG_UNIT PRIMARY KEY (org_unit_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'This entity contains all (internal) organization units like country_2 or regional subsidiaries.';
