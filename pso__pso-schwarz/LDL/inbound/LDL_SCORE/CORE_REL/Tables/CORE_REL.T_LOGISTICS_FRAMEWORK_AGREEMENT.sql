CREATE TABLE core_rel.T_LOGISTICS_FRAMEWORK_AGREEMENT (
   logistics_framework_agmt_sid        NUMBER          NOT NULL COMMENT 'Agreement unique identifier',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   logistics_framework_agmt_name       VARCHAR(100)    COMMENT 'A name that is used to identify a logistic framework agreement',
   org_unit_sid                        NUMBER          COMMENT 'The unique identifier (surrogate key) for the organization unit.',
   hauler_sid                          NUMBER          COMMENT 'The unique identifier (surrogate key) for the company.',
   logistics_area_fg                   BOOLEAN         COMMENT 'If framework agreement is relevant for logistics area',
   import_area_fg                      BOOLEAN         COMMENT 'If framework agreement  is relevant for import area',
   validity_period_from_tmsp           TIMESTAMP_LTZ(9) COMMENT 'Agreement valid from date',
   validity_period_to_tmsp             TIMESTAMP_LTZ(9) COMMENT 'Agreement valid to date',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_LOGISTICS_FRAMEWORK_AGREEMENT PRIMARY KEY (logistics_framework_agmt_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'CDM: Logistik-Rahmenvertrag. A logistics framework agreement describes the agreement between two contracting parties (logistics service provider and internal organizational unit).';
