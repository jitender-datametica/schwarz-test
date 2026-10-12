CREATE TABLE CORE.T_DIM_PRODUCT_ASSORTMENT_LIFECYCLE_2 (
   PROD_ASSORTMENT_LIFECYCLE_CD        VARCHAR(5)      NOT NULL COMMENT 'The code for the indicating if product is “new in sortiment” (NIS) and “leaving the sortiment” (ADS). ',
   PROD_ASSORTMENT_LIFECYCLE_DESCR     VARCHAR(250)    NOT NULL COMMENT 'A textual description for the product assortiment lifecycle in group language (German).',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRODUCT_ASSORTMENT_LIFECYCLE PRIMARY KEY (PROD_ASSORTMENT_LIFECYCLE_CD) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines if product is  “new in sortiment” (NIS) and “leaving the sortiment” (ADS). ';
