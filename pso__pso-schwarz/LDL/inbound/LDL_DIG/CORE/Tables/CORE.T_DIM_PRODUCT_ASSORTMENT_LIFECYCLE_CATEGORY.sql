CREATE TABLE CORE.T_DIM_PRODUCT_ASSORTMENT_LIFECYCLE_CATEGORY (
   PROD_ASSORTMENT_LIFECYCLE_CAT_CD    VARCHAR(25)     NOT NULL COMMENT 'The code for the detailed category of is a NIS/ADS categorisation  ( ex. Artikelanlage, End Of Life, etc)',
   PROD_ASSORTMENT_LIFECYCLE_CAT_DESCR VARCHAR(250)    NOT NULL COMMENT 'A textual description for the detailed category of is a NIS/ADS categorisation.',
   PROD_ASSORTMENT_LIFECYCLE_CD        VARCHAR(5)      COMMENT 'The code for the indicating if product is “new in sortiment” (NIS) and “leaving the sortiment” (ADS). ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRODUCT_ASSORTMENT_LIFECYCLE_CATEGORY PRIMARY KEY (PROD_ASSORTMENT_LIFECYCLE_CAT_CD) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the detailed category of is a NIS/ADS categorisation  ( ex. Artikelanlage, End Of Life, etc)';
