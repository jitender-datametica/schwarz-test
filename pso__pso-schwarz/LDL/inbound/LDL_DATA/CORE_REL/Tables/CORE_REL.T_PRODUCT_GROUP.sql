/* --------------------------------------------------------------------------------
   DDL for table: t_product_group
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:44
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PRODUCT_GROUP (
   prod_grp_sid                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the group of marketable products or services.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   prod_grp_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code identifying the discriminator for product groups.',
   prod_grp_nr                         VARCHAR(100)    NOT NULL COMMENT 'The number which identifies the group of products. (The number is unique among one type of product groups.)',
   prod_grp_name                       VARCHAR(250)    NOT NULL COMMENT 'The name of the product group.',
   prod_container_type_cd              VARCHAR(20)     COMMENT 'The code identifying the subtype discriminator for item containers.',
   prod_container_class_cd             VARCHAR(20)     COMMENT 'The code distinguishing between module containers and surface containers.',
   prod_container_assort_area_cd       VARCHAR(20)     COMMENT 'The code identifying the assortment area, by which product containers can be classified.',
   prod_container_size_cd              VARCHAR(20)     COMMENT 'The code identifying the size class for module containers. (small / medium / large)',
   country_org_sid                     NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the country organization which uses this product container.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PRODUCT_GROUP PRIMARY KEY (prod_grp_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'A group of marketable products or services which has been formed for a specific purpose. (Note that a group of products is not a product!)';

