/* --------------------------------------------------------------------------------
   DDL for table: t_internal_organization_real_estate
   generated from Powerdesigner on Montag, 30. September 2024 15:35:29
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_INTERNAL_ORGANIZATION_REAL_ESTATE (
   real_estate_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
   int_org_real_estate_usg_type_cd     VARCHAR(20)     NOT NULL COMMENT 'The code identifying the way, how an internal organization may use a real estate object.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   int_org_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_INTERNAL_ORGANIZATION_REAL_ESTATE PRIMARY KEY (int_org_real_estate_usg_type_cd, dwh_valid_from_tmsp, real_estate_sid) NOT ENFORCED
 )  COMMENT= 'This entity links internal organizations to the buildings in which they are located.';
