/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_ORDER_POSITION_DELIVERY_STATUS_1
   GENERATED FROM POWERDESIGNER ON Montag, 13. Februar 2023 09:55:39
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CUSTOMER_ORDER_POSITION_DELIVERY_STATUS_1 (
   CUST_ORDER_POS_DELIVERY_STATUS_CD   VARCHAR(5)      NOT NULL COMMENT 'Code that describes the delivery order status_1 of customer order position (not started, partially completed, fully completed). 
            The status_1 answers the question "Can we deliver everything that was ordered?". If customer rejects something then we cannot deliver it and status_1 will never be completed.
            ',
   CUST_ORDER_POS_DELIVERY_STATUS_DESCR VARCHAR(250)    NOT NULL COMMENT 'Code that describes the delivery order status_1 of customer order position (not started, partially completed, fully completed). 
            The status_1 answers the question "Can we deliver everything that was ordered?". If customer rejects something then we cannot deliver it and status_1 will never be completed.
            A " Fully Completed" delivery order status_1 in this case means that for everrything that was ordered we have  a completed Delivery Order.
            So status_1 here can be changed back from "Fully Completed" to "Partially Completed" for example',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_CUSTOMER_ORDER_POSITION_DELIVERY_STATUS PRIMARY KEY (CUST_ORDER_POS_DELIVERY_STATUS_CD) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the delivery statuses of each customer order position. If a customer rejects delivery the status_1 will NOT  be completed, because we cannot deliver everything that is ordered';
