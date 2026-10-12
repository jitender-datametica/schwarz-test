CREATE TABLE ETL_PROCESS.T_ETL_PRODUCT_STOCK_INDICATOR_1 (
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'Theunique identifier(surrogate key) for product variant',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   PRODUCT_EWM_MAT_ID                  VARCHAR(50)     COMMENT 'The ewm material identifier',
   STOCK_PLACEMENT_CD                  VARCHAR(10)     COMMENT 'The code for stock palcement',
   STOCK_REMOVAL_CD                    VARCHAR(10)     COMMENT 'The code for stock removal',
   WH_SID                              NUMBER          COMMENT 'The unique identifier for the warehouse',
   WH_CD                               VARCHAR(5)      COMMENT 'A short  unique code for warehouse',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_PRODUCT_STOCK_INDICATOR PRIMARY KEY (PROD_VARIANT_SID) NOT ENFORCED
 )  COMMENT= 'The etl support table to connect EWM mapping data to retail t_fact_goods_movement_1';
