/* --------------------------------------------------------------------------------
   DDL for table: t_product_variant_stock_restriction_1
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PRODUCT_VARIANT_STOCK_RESTRICTION_1 (
   prod_variant_sid                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a variant of a product, for which the restriction applies.',
   int_org_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization which defines the restriction.',
   stock_restriction_type_cd           VARCHAR(20)     NOT NULL COMMENT 'The code identifying the the kind of restriction regarding the stock which has to be kept for a product.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   stock_qty                           NUMBER(38, 5)   NOT NULL COMMENT 'The stock quantity which is desribed by the restriction.',
   logistic_uom_cd                     VARCHAR(20)     NOT NULL COMMENT 'The code identifying the logistic unit_1 of measure. (e.g. palettes, boxes, pieces or layers on a palette)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PRODUCT_VARIANT_STOCK_RESTRICTION PRIMARY KEY (stock_restriction_type_cd, int_org_sid, prod_variant_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'Some product need to be available in certain quantities, e.g. there is a mininum or a maximum stock quantity.';

