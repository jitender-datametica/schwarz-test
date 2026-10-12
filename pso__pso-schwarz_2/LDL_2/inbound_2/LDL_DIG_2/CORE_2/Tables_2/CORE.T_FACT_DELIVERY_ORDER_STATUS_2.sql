/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_DELIVERY_ORDER_STATUS_2
   GENERATED FROM POWERDESIGNER ON Montag, 13. Februar 2023 09:54:43
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_DELIVERY_ORDER_STATUS_2 (
   DELIVERY_ORDER_SID                  NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for delivery order ',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   DELIVERY_ORDER_NR                   VARCHAR(20)     COMMENT 'Delivery order number ',
   DELIVERY_ORDER_STATUS_CD            VARCHAR(5)      COMMENT 'Status_2 of the Delivery Order. It is aggregate of the statuses of All Delivery Order Position. 
            Set to C (completed) means "For All SalesOrderPositions we have created associated DeliveryOrderPositions with the respective quantities that need to be delivered" It does not meat "item_2 has left the warehouse and is delivered and accepted by customer"
            ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',
   CONSTRAINT PK_T_FACT_DELIVERY_ORDER_STATUS PRIMARY KEY (DELIVERY_ORDER_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'The table keeps history of changes in different statuses at Delivery Order level. These statuses are put in separate table (as opposed to T_FACT_GOODS_MOVEMENT_2)  because we want to have full history of status_2 changes and also for performance reason - we want to be able to frequently add/update statuses';
