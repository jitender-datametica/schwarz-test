/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_ORDER_PROCESS_STATUS
   GENERATED FROM POWERDESIGNER ON Montag, 13. Februar 2023 09:55:11
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CUSTOMER_ORDER_PROCESS_STATUS (
   CUST_ORDER_PROCESS_STATUS_CD        VARCHAR(5)      NOT NULL COMMENT 'Code that describes the overall processing status of Customer Order (not started, partially completed, fully completed). 
            Status in this field is based on the status of all Delivery Orders, Warehouse Movement Orders related to this Customer Order',
   CUST_ORDER_PROCESS_STATUS_DESCR     VARCHAR(250)    NOT NULL COMMENT 'Code that describes the overall processing status of Customer Order (not started, partially completed, fully completed). 
            Status in this field is based on the status of all Delivery Orders, Warehouse Movement Orders related to this Customer Order
            A Fully Completed status means that all related orders for this Customer Order (meaning all Delivery Orders, Warehouse Movement Orders...) have their Overall Status set to completed',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_CUSTOMER_ORDER_PROCESS_STATUS PRIMARY KEY (CUST_ORDER_PROCESS_STATUS_CD) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the statuses of processing a customer order';
