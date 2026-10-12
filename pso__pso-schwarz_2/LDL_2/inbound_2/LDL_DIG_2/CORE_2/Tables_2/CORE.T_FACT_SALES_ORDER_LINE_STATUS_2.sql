/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_SALES_ORDER_LINE_STATUS_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 13. Juli 2023 11:47:24
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_SALES_ORDER_LINE_STATUS_2 (
   SALE_ORDER_SID                      NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key)  for sales_2 order ( customer or intercompany)',
   SALE_ORDER_POS_NR                   NUMBER          NOT NULL COMMENT 'The particular position number of an item_2 in an order',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   DIST_CHANNEL_CD                     VARCHAR(5)      COMMENT 'The code for the distribution channel ( a channel  through which the goods are sold )',
   SALE_ORDER_NR                       VARCHAR(20)     COMMENT 'The original order number of the source system',
   SALE_ORDER_POS_DELIVERY_STATUS_CD   VARCHAR(5)      COMMENT 'Code that describes the delivery order status_2 of  order position (not started, partially completed, fully completed). 
            A " Fully Completed" delivery order status_2 in this case means that for everrything that was ordered we have  a completed Delivery Order.
            If we have rejection by customer this means that one or more Delivery Orders are not Completed so the status_2 here will also never be Completed.
            So status_2 here can be changed back from "Fully Completed" to "Partially Completed" for example',
   SALE_ORDER_POS_OVERALL_DELIVERY_STATUS_CD VARCHAR(5)      COMMENT 'Code that describes the overall delivery status_2 of order position (not started, partially completed, fully completed). 
            A " Fully Completed" delivery order status_2 in this case means that for everrything that HAS TO BE DELIVERED a completed Delivery Order exists.
            If we have rejection this means that there is nothing to be delivered and we sill count this as "Completed").
            ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',
   CONSTRAINT PK_T_FACT_SALES_ORDER_LINE_STATUS PRIMARY KEY (SALE_ORDER_SID, SALE_ORDER_POS_NR, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'The table keeps history of changes in different statuses (like delivery) at Sales_2 Order level (Customer Order and Intercompany Order ) level. These statuses are put in separate table (as opposed to putting them in T_FACT_CUSTOMER_ORDER_LINE_2 or T_FACT_INTERCOMPANY_ORDER_LINE_2) because we want to have full history of status_2 changes and also for performance reason - we want to be able to frequently add/update statuses';
