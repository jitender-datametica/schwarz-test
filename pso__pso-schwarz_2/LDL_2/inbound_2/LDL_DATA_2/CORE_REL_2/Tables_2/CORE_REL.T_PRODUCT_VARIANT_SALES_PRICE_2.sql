/* --------------------------------------------------------------------------------
   DDL for table: t_product_variant_sales_price_2
   generated from Powerdesigner on Dienstag, 22. Oktober 2024 13:33:07
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PRODUCT_VARIANT_SALES_PRICE_2 (
   prod_variant_sid                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a sales_2 variant of a product.',
   price_grp_sid                       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the price level of a product.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   sales_gross_price                   NUMBER(38, 5)   NOT NULL COMMENT 'The gross price for which this product variant is sold in the store.',
   curr_cd                             VARCHAR(3)      NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217.',
   price_reason_cd                     VARCHAR(20)     COMMENT 'The code identifying the reason why a price was defined for a product. E.g. permanent price change, promotional price, etc.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PRODUCT_VARIANT_SALES_PRICE PRIMARY KEY (prod_variant_sid, price_grp_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'This entity tracks the sales_2 price of a product, depending on the price level.';