/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_PRODUCT_ASSORTMENT_LIFECYCLE_2
   GENERATED FROM POWERDESIGNER ON Montag, 22. August 2022 13:44:05
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_REL_PRODUCT_ASSORTMENT_LIFECYCLE_2 (
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant',
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2',
   PROD_ASSORTMENT_LIFECYCLE_CAT_CD    VARCHAR(25)     NOT NULL COMMENT 'The code for the detailed category of is a NIS/ADS categorisation  ( ex. Artikelanlage, End Of Life, etc)',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   PROD_ASSORTMENT_LIFECYCLE_CD        VARCHAR(5)      COMMENT 'The code for the indicating if product is “new in sortiment” (NIS) and “leaving the sortiment” (ADS). ',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',
   CONSTRAINT PK_T_REL_PRODUCT_ASSORTMENT_LIFECYCLE PRIMARY KEY (PROD_VARIANT_SID, WSHOP_CD, PROD_ASSORTMENT_LIFECYCLE_CAT_CD, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'This dimension defines if product is a new “new in sortiment” (NIS) and “leaving the sortiment” (ADS). ';
