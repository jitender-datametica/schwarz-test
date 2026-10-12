CREATE TABLE CORE.T_DIM_PRODUCT_WORLD_OF_NEED_2 (
   WORLD_OF_NEED_CD                    VARCHAR(50)     NOT NULL COMMENT 'The code for the main World of Need which the product has been automatically assigned.',
   WORLD_OF_NEED_NAME                  VARCHAR(100)    COMMENT 'The description for world of need product category',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_PRODUCT_WORLD_OF_NEED PRIMARY KEY (WORLD_OF_NEED_CD) NOT ENFORCED 
)  COMMENT = 'The World of Needs categorization system groups products into six broad categories to simplify and organize the vast array of products (such as ''Kids and Toys'', ''Fashion and Lifestyle'', etc.). This is a higher level of World of Need/category of need/subcategory product categorization.';
