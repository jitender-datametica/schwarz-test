/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_STOCK_ALLOCATION_ENTITY_DAILY
   GENERATED FROM POWERDESIGNER ON Montag, 24. Juli 2023 16:40:05
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_STOCK_ALLOCATION_ENTITY_DAILY (
   WH_ALLOC_ENTITY_CD                  VARCHAR(5)      NOT NULL COMMENT 'A code for warehouse allocation unit  (LI_DE , LI_CZ, KFL_DE, KFL_CZ , INT etc)',
   PROD_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product',
   CAL_DT                              DATE            NOT NULL COMMENT 'The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). ',
   ACTIVE_FG                           BOOLEAN         COMMENT 'An indicator showing the current record from a business perspective,',
   ALLOC_PROMO_CLASS_CD                VARCHAR(5)      COMMENT 'The code for the indicating if product is a part of special offer or normal or special assortiment',
   DISTRIBUTION_PCT                    NUMBER(38, 5)   COMMENT 'The amount of stock which is currently available within the specific warehouse. All of the stock can be sold within the onlineshop and is stored in an internal warehouse.',
   PROD_NR                             VARCHAR(20)     COMMENT 'The number for internal onlineshop product, which is country independent',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_FACT_STOCK_ALLOCATION_ENTITY_DAILY PRIMARY KEY (WH_ALLOC_ENTITY_CD, PROD_SID, CAL_DT) NOT ENFORCED
 )  COMMENT= 'The table contains the daily calculated allocation of products among allocation entities ( countries )';
