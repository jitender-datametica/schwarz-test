CREATE TABLE CORE_REL.T_WAWI_ITEM_TO_PRODUCT_GROUP_2 (
   wawi_item_sid                       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item.',
   prod_grp_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code identifying the discriminator for product groups.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   prod_grp_sid                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the group of marketable products or services.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_WAWI_ITEM_TO_PRODUCT_GROUP PRIMARY KEY (wawi_item_sid, prod_grp_type_cd, dwh_valid_from_tmsp) NOT ENFORCED
)  COMMENT= 'This table relates Wawi items to product groups. A Wawi item_2 may belong to more than one product group at the same time, however for a given product group type a Wawi item_2 can be assigned to only one product group, so that Wawi items and product groups form a hierarchy.';