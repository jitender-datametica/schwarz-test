--==============================================================
-- Table: t_product_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_product_1
   generated from Powerdesigner on Donnerstag, 6. Juni 2024 10:04:48
*/ --------------------------------------------------------------------------------
CREATE TABLE CORE_REL.T_PRODUCT_1 (
   product_sid                         NUMBER           NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN          NOT NULL COMMENT 'An indicator showing the current record in history.',
   product_status_cd                   VARCHAR(20)      COMMENT 'The code for the status_1 of the product.',
   bus_country_cd                      VARCHAR(2)       COMMENT 'A two-character code according to the business definition of Kaufland or Lidl.',
   product_type_cd                     VARCHAR(20)      COMMENT 'A code for the type of the product e.g. TRADE.',
   product_nr                          VARCHAR(20)      COMMENT 'The number by which the product is known.',
   int_product_nr                      VARCHAR(20)      COMMENT 'The number by which the product is known internationally.',
   product_name                        VARCHAR(100)     COMMENT 'The name by which the product is known.',
   int_product_name                    VARCHAR(100)     COMMENT 'The name by which the product is known internationally.',
   nonfood_fg                          BOOLEAN          COMMENT 'Indicates, whether it is a nonfood product.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_PRODUCT PRIMARY KEY (product_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'This entity contains all products that are purchased and/or sold.';

