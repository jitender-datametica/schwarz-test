/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_DELIVERY_ORDER_STATUS_1
   GENERATED FROM POWERDESIGNER ON Montag, 13. Februar 2023 09:56:21
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_DELIVERY_ORDER_STATUS_1 (
   DELIVERY_ORDER_STATUS_CD            VARCHAR(5)      NOT NULL COMMENT 'Status_1 of the Delivery Order document. It is aggregate of the statuses of All Delivery Order Position. ',
   DELIVERY_ORDER_STATUS_DESCR         VARCHAR(250)    NOT NULL COMMENT 'Status_1 of the Delivery Order document. It is aggregate of the statuses of All Delivery Order Position. 
            Set to C (completed) means "For All SalesOrderPositions we have created associated DeliveryOrderPositions with the respective quantities that need to be delivered" It does not meat "item_1 has left the warehouse and is delivered and accepted by customer"
            ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_DELIVERY_ORDER_STATUS PRIMARY KEY (DELIVERY_ORDER_STATUS_CD) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the statuses of a delivering order. Not to be confused with actual transporting of items from a warehouse to a customer.
             A Delivery Order is a document. Such document has a status_1 Completed when all  position (lines) from this document are associated with Customer Sales_1 order, which means all required items to fulfil a customer order are present in a warehouse.';
