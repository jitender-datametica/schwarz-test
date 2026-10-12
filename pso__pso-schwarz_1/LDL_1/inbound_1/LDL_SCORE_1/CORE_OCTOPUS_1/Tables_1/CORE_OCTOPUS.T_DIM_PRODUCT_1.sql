CREATE TABLE CORE_OCTOPUS.T_DIM_PRODUCT_1 (
   product_sid                         NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
   bus_country_cd                      VARCHAR(2)      COMMENT 'Business country_1 to which the good is dedicated to',
   product_nr                          VARCHAR(20)     COMMENT 'The number by which the product is known.',
   int_product_nr                      VARCHAR(20)     COMMENT 'The number by which the product is known internationally.',
   product_name                        VARCHAR(100)    COMMENT 'The name by which the product is known.',
   int_product_name                    VARCHAR(100)    COMMENT 'The name by which the product is known internationally.',
   nonfood_fg                          BOOLEAN         COMMENT 'Indicates, whether it is a nonfood product.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_PRODUCT PRIMARY KEY (product_sid) NOT ENFORCED 
)  COMMENT = 'The products that are used in a dispo order. ';
