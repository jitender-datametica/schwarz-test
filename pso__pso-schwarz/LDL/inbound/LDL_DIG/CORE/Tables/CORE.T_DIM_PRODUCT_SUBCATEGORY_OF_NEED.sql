CREATE TABLE CORE.T_DIM_PRODUCT_SUBCATEGORY_OF_NEED (
   SUBCATEGORY_OF_NEED_CD              VARCHAR(50)     NOT NULL COMMENT 'The code for main subcategory of Need which the product has been automatically assigned.',
   SUBCATEGORY_OF_NEED_NAME            VARCHAR(100)    COMMENT 'The description for subcategory of need product category',
   CATEGORY_OF_NEED_CD                 VARCHAR(50)     COMMENT 'The code for main Category of Need which the product has been automatically assigned.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_PRODUCT_SUBCATEGORY_OF_NEED PRIMARY KEY (SUBCATEGORY_OF_NEED_CD) NOT ENFORCED 
)  COMMENT = 'The World of Needs categorization system groups products into six broad categories to simplify and organize the vast array of products. A Subcategory of Need represents a lowest level of this product categorization (example: Redwine).';
