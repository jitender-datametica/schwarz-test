/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_SALES_ORDER_STATUS_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 13. Juli 2023 11:50:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_SALES_ORDER_STATUS_2 (
   SALE_ORDER_SID                      NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for sales_2 order ( customer or intercompany)',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   DIST_CHANNEL_CD                     VARCHAR(5)      COMMENT 'The code for the distribution channel ( a channel  through which the goods are sold )',
   SALE_ORDER_NR                       VARCHAR(20)     COMMENT 'The original order number of the source system',
   SALE_ORDER_PROCESS_STATUS_CD        VARCHAR(5)      COMMENT 'Code that describes the overall processing status_2 of Sales_2 Order (not started, partially completed, fully completed). 
            Status_2 in this field is based on the status_2 of all Delivery Orders, Warehouse Movement Orders related to this Customer Order',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',
   CONSTRAINT PK_T_FACT_SALES_ORDER_STATUS PRIMARY KEY (SALE_ORDER_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'The table keeps history of changes in different statuses (like delivery, processing) at Sales_2 Order level (Customer Order and Intercompany Order ) level. These statuses are put in separate table (as opposed to putting them in T_FACT_CUSTOMER_ORDER_LINE_2  or T_FACT_INTERCOMPANY_ORDER_LINE_2) because we want to have full history of status_2 changes and also for performance reason - we want to be able to frequently add/update statuses';
