CREATE TABLE CORE.T_FACT_PRODUCT_STOCK_AGE_2 (
   CAL_DT                              DATE            NOT NULL COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant',
   ACTIVE_FG                           BOOLEAN         COMMENT 'An indicator showing the current record from a business perspective',
   PROD_STOCK_AGE_CLUSTER_CD           VARCHAR(5)      COMMENT 'A code for aggregation of product stock into age clusters to define how long products have been stored in our warehouse.',
   REF_BOOKING_DT                DATE            COMMENT 'The date when the booking reference has been made',
   FIRST_INBOUND_DT                    DATE            COMMENT 'Min posting date in material movement document for each Product Variant. For Product Level (head level) it is considered the Min date for all the Product Variants. ',
   DELTA_DAY_CNT                       NUMBER          COMMENT 'The count of delta days',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   CONSTRAINT PK_T_FACT_PRODUCT_STOCK_AGE PRIMARY KEY (PROD_VARIANT_SID, CAL_DT) NOT ENFORCED
 )  COMMENT= 'The fact  table with product clustering to facilitate stock utilisation  based on how long products have been stored in our warehouse. ';
