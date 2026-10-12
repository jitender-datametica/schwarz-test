/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_STOCK_WAREHOUSE_ALLOCATION_DAILY_1
   GENERATED FROM POWERDESIGNER ON Montag, 24. Juli 2023 16:38:56
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_STOCK_WAREHOUSE_ALLOCATION_DAILY_1 (
   WH_ALLOC_ENTITY_CD                  VARCHAR(5)      NOT NULL COMMENT 'A code for warehouse allocation unit_1  (LI_DE , LI_CZ, KFL_DE, KFL_CZ , INT etc)',
   WH_SID                              NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the warehouse',
   PROD_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product',
   CAL_DT                              DATE            NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
   ALLOC_PROMO_CLASS_CD                VARCHAR(5)      COMMENT 'The code for the indicating if product is a part of special offer or normal or special assortiment',
   WH_CD                               VARCHAR(5)      COMMENT 'A short unique code for the warehouses which receives the deliveries',
   ACTIVE_FG                           BOOLEAN         COMMENT 'An indicator showing the current record from a business perspective,',
   DISTRIBUTION_PCT                    NUMBER(38, 5)   COMMENT 'The amount of stock which is currently available within the specific warehouse. All of the stock can be sold within the onlineshop and is stored in an internal warehouse.',
   PROD_NR                             VARCHAR(20)     COMMENT 'The number for internal onlineshop product, which is country_1 independent',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_FACT_STOCK_WAREHOUSE_ALLOCATION_DAILY PRIMARY KEY (WH_ALLOC_ENTITY_CD, WH_SID, PROD_SID, CAL_DT) NOT ENFORCED
 )  COMMENT= 'The table is derived from t_fact_stock_allocation_entity_daily_1 cross joined with warehouse table to deliver data in the form business expects';
