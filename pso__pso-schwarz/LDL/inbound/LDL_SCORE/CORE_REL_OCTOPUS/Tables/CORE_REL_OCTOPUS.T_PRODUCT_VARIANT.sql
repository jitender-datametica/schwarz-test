CREATE TABLE CORE_REL_OCTOPUS.T_PRODUCT_VARIANT (
   product_variant_sid                 NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   product_variant_type_cd             VARCHAR(20)     COMMENT 'The code for the type of the product variant e.g. LOG',
   product_variant_status_cd           VARCHAR(20)     COMMENT 'The code for the status of the product variant.',
   gtin_nr                             VARCHAR(14)     COMMENT 'The Global Trade Item Number (GTIN) is an identifier for trade items, developed by GS1. It identifies single product variants and/or logistic variants.',
   int_product_nr                      VARCHAR(20)     COMMENT 'The number by which the product is known internationally.',
   int_product_name                    VARCHAR(100)    COMMENT 'The name by which the product is known internationally.',
   uom_cd                              VARCHAR(20)     COMMENT 'A code for the unit of measure associated with the package quantity.',
   packaging_cd                        VARCHAR(20)     COMMENT 'A code for the packaging.',
   package_qty                         NUMBER(38, 5)   COMMENT 'The quantity that is in a single package.',
   case_size_qty                       NUMBER          COMMENT 'Number of units that a logistic variant contains.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',   
   CONSTRAINT PK_T_PRODUCT_VARIANT PRIMARY KEY (product_variant_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'This entity contains all product variants related to a product that are purchased and/or sold.
             It is either a logistic variant that is typically transported and/or a style variant.';
