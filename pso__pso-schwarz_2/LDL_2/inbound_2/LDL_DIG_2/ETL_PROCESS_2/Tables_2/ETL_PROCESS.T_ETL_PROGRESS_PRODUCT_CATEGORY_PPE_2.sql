CREATE TABLE ETL_PROCESS.T_ETL_PROGRESS_PRODUCT_CATEGORY_PPE_2 (
   PROD_SID                            NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the product',
   META_TIMESTAMP                      TIMESTAMP_TZ(9) COMMENT 'The meta timestamp indicated in source data.',
   PROD_CATEGORY_PPE_NAME              VARCHAR(250)    COMMENT 'The name of the PPE category which the product has been automatically assigned (Profilierung / Pflicht / Ergänzung).',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_PROGRESS_PRODUCT_CATEGORY_PPE PRIMARY KEY (PROD_SID) NOT ENFORCED 
)  COMMENT = 'A new categorization of products is available for the Online Shop in all countries, where products can be assigned to one of three categories: Profilierung, Pflicht, or Ergänzung. This categorization is not obligatory.
             
             Source: Progress';