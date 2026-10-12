CREATE TABLE CORE.T_FACT_PRODUCT_UTILISATION (
   PROD_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   UTIL_ACTION_CD                      VARCHAR(20)     NOT NULL COMMENT 'The unique code for  the way the product goes under utilisaton (Utilisation,  Discontinuation etc)',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   EXCEPTION_UTIL_DT                   DATE            COMMENT 'We have specific Utilization dates for articles, which can change from time to time. This is case then the utilization date gets replaced with a new one.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',
   PROD_NR                             VARCHAR(20)     COMMENT 'The number for internal onlineshop product, which is country independent',
   CONSTRAINT PK_T_FACT_PRODUCT_UTILISATION PRIMARY KEY (PROD_SID, DWH_VALID_FROM_TMSP, UTIL_ACTION_CD)
       NOT ENFORCED
)
COMMENT = 'This minor dimension defines the way the product gets utilised';
