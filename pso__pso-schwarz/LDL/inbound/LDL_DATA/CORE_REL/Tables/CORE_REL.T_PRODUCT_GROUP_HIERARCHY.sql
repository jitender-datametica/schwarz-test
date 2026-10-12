/* --------------------------------------------------------------------------------
   DDL for table: t_product_group_hierarchy
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:47
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PRODUCT_GROUP_HIERARCHY (
   prod_grp_sid                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the group of marketable products or services.',
   prod_grp_hierarchy_type_cd          VARCHAR(20)     NOT NULL COMMENT 'The code identifying the kind of hierarchy for product groups.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   parent_prod_grp_sid                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the group of marketable products or services, which is one level up in the hierarchy defined by the hierarchy type code.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PRODUCT_GROUP_HIERARCHY PRIMARY KEY (prod_grp_hierarchy_type_cd, prod_grp_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'This entity tracks the hierarchy of product groups. It relates a group of products to its parent group one level up in the hierarchy. This entity can store multiple hierarchies. The kind of hierarchy is identified by the hierarchy type code.';

