/* --------------------------------------------------------------------------------
   DDL for table: t_product_status
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:47
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PRODUCT_STATUS (
   prod_sid                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
   prod_status_categ_cd                VARCHAR(20)     NOT NULL COMMENT 'The code identifying the kind of status lifecycle for products.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   prod_status_type_cd                 VARCHAR(20)     NOT NULL COMMENT 'The code for the lifecycle status for products.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PRODUCT_STATUS PRIMARY KEY (prod_sid, prod_status_categ_cd, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'This entity tracks the lifecycle status of products, as seen from a global (i.e. not country-specific) perspective. There may be more than one lifecycle for a given product, e.g. the buying status and the workflow status for non-food items or the status in the retail system. The lifecycle is identified by the status category code. For a given status category, a product has one status code.';

