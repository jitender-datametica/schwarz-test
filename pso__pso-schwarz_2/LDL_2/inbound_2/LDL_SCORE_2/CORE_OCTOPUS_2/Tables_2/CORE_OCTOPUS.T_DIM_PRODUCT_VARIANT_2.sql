CREATE TABLE CORE_OCTOPUS.T_DIM_PRODUCT_VARIANT_2 (
   product_variant_sid                 NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant.',
   gtin_nr                             VARCHAR(14)     COMMENT 'GTIN for the variant of the product',
   int_product_nr                      VARCHAR(20)     COMMENT 'The number by which the product is known internationally.',
   int_product_name                    VARCHAR(100)    COMMENT 'The name by which the product is known internationally.',
   case_size_qty                       NUMBER(38, 5)   COMMENT 'Number of units that a logistic variant contains.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_PRODUCT_VARIANT PRIMARY KEY (product_variant_sid) NOT ENFORCED 
)  COMMENT = 'One product may have several variants. The information can be retrieved from the GTIN. For example ice cream (classic flavor, strawberry flavor etc.). ';
