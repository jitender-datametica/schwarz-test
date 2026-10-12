/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_STOCK_KNOCKDOWN
   GENERATED FROM POWERDESIGNER ON Montag, 6. Mai 2024 16:54:55
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_STOCK_KNOCKDOWN (
   KNOCKDOWN_POSTING_DT                DATE            NOT NULL COMMENT 'Date when the posting(booking) in accounting system was made',
   KNOCKDOWN_DT                        DATE            NOT NULL COMMENT 'Date at which the loss of value takes effect.',
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'Surrogate key for the Product Variant',
   INTERNAL_COMPANY_SID                NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the company',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   INTERNAL_COMPANY_CD                 VARCHAR(5)      COMMENT 'Unique identifier of the company to which we book accounting documents in the source system (SAP)',
   FIRST_INBOUND_DT                    DATE            COMMENT 'Earliest posting date in material movement document for each Product Variant.',
   STOCK_KNOCKDOWN_CATEGORY_CD         VARCHAR(20)     COMMENT '	A code of the category of value knock-down (a.k.a  write-down or devaluation of asset). Categories are based on how long stock remained in the warehouse and how much items were sold.',
   KNOCKDOWN_STOCK_CNT                 NUMBER          COMMENT 'How many of the stock items stored in the warehouse, lost part of their value',
   TOTAL_STOCK_CNT                     NUMBER          COMMENT 'The total stock of the product variant -how many items of the product variant are stored in the warehouse',
   TOTAL_STOCK_NET_EUR_VAL             NUMBER(38, 5)   COMMENT 'Total value (before the knockdown process) of all items for this product variant that are  present in stock (independently if they are considered for knockdown or not)',
   UNIT_STOCK_KNOCKDOWN_EVAL_NET_EUR_VAL NUMBER(38, 5)   COMMENT 'Base price per single unit of the Product Variant - before the knockdown. Used to evaluate the stock (It is the smallest price assigned to a product variant (between GLD/IVP/EKP/VKP) at the knockdown_dt) ',
   TOTAL_STOCK_KNOCKDOWN_EVAL_NET_EUR_VAL NUMBER(38, 5)   COMMENT 'Total value of the items considered for knockdown in stock of the Product Variant (equals to KNOCKDOWN_STOCK_CNT *  UNIT_STOCK_KNOCKDOWN_EVAL_NET_EUR_VAL). 
            This amount will be written off from TOTAL_STOCK_NET_EUR_VAL to get the new value of all items in stock after the depreciation',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_STOCK_KNOCKDOWN PRIMARY KEY (KNOCKDOWN_POSTING_DT, KNOCKDOWN_DT, PROD_VARIANT_SID, INTERNAL_COMPANY_SID) NOT ENFORCED 
)  COMMENT = 'ETL table that helps loading T_FACT_STOCK_KNOCKDOWN. Main source is SAP
             The table contains data for items that are in stock (within the warehouses) and their prices have to be reduced. 
             In GERMAN - RWA. Means Reichweitenabschlag -> English: stock_knockdown -> value reduction of unsold stock based on the time spent in the warehouse
             
             The granularity of the table is Prod Variant (what assests are depreciated), Knockdown Date (on which date the assets value depreciated ), Knockdown Posting DT (on which date the record for stock depreciation was posted in the accounting system) and Internal Company (which company owns the assests that are losing value). As of April 2024, all stock is owned by Lidl Dig Trading GmbH&Co, which means the only value in INTERNAL_COMPANY_CD will be D888';
