/* --------------------------------------------------------------------------------
   DDL for table: t_product_variant_internal_organization_status
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PRODUCT_VARIANT_INTERNAL_ORGANIZATION_STATUS (
   prod_variant_sid                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a variant of a product.',
   int_org_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   prod_variant_status_type_cd         VARCHAR(20)     NOT NULL COMMENT 'The code for the lifecycle status for product variants.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PRODUCT_VARIANT_INTERNAL_ORGANIZATION_STATUS PRIMARY KEY (int_org_sid, prod_variant_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'This entity tracks the status of a product variant in the various internal organizations, i.e. country organizations, regional organizations and stores. (Note that a product variant might have a different status on each level of the organiziational hierarchy.)';

