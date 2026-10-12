/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_ORDER_POSITION_OVERALL_DELIVERY_STATUS_2
   GENERATED FROM POWERDESIGNER ON Montag, 13. Februar 2023 09:55:55
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CUSTOMER_ORDER_POSITION_OVERALL_DELIVERY_STATUS_2 (
   CUST_ORDER_POS_OVERALL_DELIVERY_STATUS_CD VARCHAR(5)      NOT NULL COMMENT 'Code that describes the overall delivery order. status_2 of customer order position (not started, partially completed, fully completed). 
            A " Fully Completed" delivery order status_2 in this case means that for everrything that HAS TO BE DELIVERED a completed Delivery Order exists.
            If we have rejection this means that there is nothing to be delivered and we sill count this as "Completed").
            ',
   CUST_ORDER_POS_OVERALL_DELIVERY_STATUS_DESCR VARCHAR(250)    NOT NULL COMMENT 'Code that describes the overall delivery order. status_2 of customer order position (not started, partially completed, fully completed). 
            A " Fully Completed" delivery order status_2 in this case means that for everrything that HAS TO BE DELIVERED a completed Delivery Order exists.
            If we have rejection this means that there is nothing to be delivered and we sill count this as "Completed").
            ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_CUSTOMER_ORDER_POSITION_OVERALL_DELIVERY_STATUS PRIMARY KEY (CUST_ORDER_POS_OVERALL_DELIVERY_STATUS_CD) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the delivery statuses of each customer order position. If a customer rejects delivery the status_2 will still be completed, because we have nothing left to deliver';
