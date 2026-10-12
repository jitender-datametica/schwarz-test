/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_SALES_ORDER_LINE_STATUS_PROGRESS_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 1. November 2023 10:48:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_SALES_ORDER_LINE_STATUS_PROGRESS_2 (
   SALE_ORDER_SID                      NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for customer order',
   SALE_ORDER_POS_NR                   NUMBER(38,0)    NOT NULL COMMENT 'A number of an particular position ( product ) in an order',
   DELIVERY_ORDER_SID                  NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for delivery order ',
   PACK_SID                            NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the package.',
   WSHOP_CD                            VARCHAR(5)      COMMENT 'Sales_2 Organization/Webshop through which the order was placed',
   DIST_CHANNEL_CD                     VARCHAR(5)      COMMENT 'The code for the distribution channel ( a channel  through which the goods are sold )',
   SALE_ORDER_NR                       VARCHAR(20)     COMMENT 'The original order number of the source system',
   SALE_ORDER_DT                       DATE            COMMENT 'The date when order was made',
   DELIVERY_ORDER_NR                   VARCHAR(20)     COMMENT 'The order number from the system that processes deliveries',
   PACK_ORDER_NR                       VARCHAR(20)     COMMENT 'The order number within warehouse system which tells which articles are part of which package_2',
   IS_BLOCKED_DELIVERY_FG              BOOLEAN         COMMENT 'Flag which tells whether a delivery is being blocked currently. e.g. if customer orders with payment type \"Vorauskasse\" then the delivery will only start as soon as the money arrives',
   DELIVERY_BLOCKED_REASON_CD          VARCHAR(5)      COMMENT 'The code with the reason why the delivery is blocked for the specific customer order.',
   SALE_ORDER_PROCESS_STATUS_CD        VARCHAR(5)      COMMENT 'Code that describes the overall processing status_2 of Customer Order (not started, partially completed, fully completed). 
            Status_2 in this field is based on the status_2 of all Delivery Orders, Warehouse Movement Orders related to this Customer Order',
   SALE_ORDER_POS_DELIVERY_STATUS_CD   VARCHAR(5)      COMMENT 'Code that describes the delivery order status_2 of customer order position (not started, partially completed, fully completed). 
            A " Fully Completed" delivery order status_2 in this case means that for everrything that was ordered we have  a completed Delivery Order.
            If we have rejection by customer this means that one or more Delivery Orders are not Completed so the status_2 here will also never be Completed.
            So status_2 here can be changed back from "Fully Completed" to "Partially Completed" for example',
   SALE_ORDER_POS_OVERALL_DELIVERY_STATUS_CD VARCHAR(5)      COMMENT 'Code that describes the overall delivery order. status_2 of customer order position (not started, partially completed, fully completed). 
            A " Fully Completed" delivery order status_2 in this case means that for everrything that HAS TO BE DELIVERED a completed Delivery Order exists.
            If we have rejection this means that there is nothing to be delivered and we sill count this as "Completed").
            ',
   WH_SID                              NUMBER          COMMENT 'The unique identifier (sk) for the warehouse from where particular product will be sent',
   PROD_VARIANT_SID                    NUMBER          COMMENT 'Ordered product',
   PROD_TGT_DELIVERY_TIME              NUMBER          COMMENT 'This field comes from the VLT-Tool and tells how much time is expected for the delivery for a specific product variant. The value is country_2 dependant.',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'Quantity of a particular product ordered',
   DELIVERY_SRC_TYPE_CD                VARCHAR(5)      COMMENT 'The code for source location_2 of product from where it is delivered i.e. from supplier_2 or warehouse directly',
   DELIVERY_TYPE_CD                    VARCHAR(5)      COMMENT 'The code for the package_2 delivery type  (Home Delivery, Shop Delivery, Locker Delivery)',
   DELIVERY_TGT_DT                     DATE            COMMENT 'First date which has been communicated to the customer until when the shipment is meant to arrive',
   HAULER_SID                          NUMBER          COMMENT 'The unique identifier (surrogate key) for hauler',
   CUST_ORDER_TYPE_CD                  VARCHAR(5)      COMMENT 'The unique code for the customer order type',
   WH_LEAVE_ACTUAL_TMSP                TIMESTAMP_TZ(9) COMMENT 'The timestamp when the truck actually left the warehouse platform (\"Rampe\") from which the package_2 is sent to the customer',
   WH_LEAVE_TGT_TMSP                   TIMESTAMP_TZ(9) COMMENT 'The timestamp when the truck is meant to leave for the specific tracking id. The time is known as CPT. The time depends on the warehouse, the carrier, the workday and the shipment type',
   DELIVERY_PROD_QTY                   NUMBER(38, 5)   COMMENT 'The number of products that are to be delivered',
   DELIVERY_ORDER_STATUS_CD            VARCHAR(5)      COMMENT 'Status_2 of the Delivery Order. It is aggregate of the statuses of All Delivery Order Position. 
            Set to C (completed) means "For All SalesOrderPositions we have created associated DeliveryOrderPositions with the respective quantities that need to be delivered" It does not meat "item_2 has left the warehouse and is delivered and accepted by customer"
            ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',
   CONSTRAINT PK_T_FACT_SALES_ORDER_LINE_STATUS_PROGRESS PRIMARY KEY (SALE_ORDER_SID, SALE_ORDER_POS_NR, DELIVERY_ORDER_SID, PACK_SID) NOT ENFORCED
 )  COMMENT= 'An accumulating snapshot_2 fact table which tracks the progress in the steps through which a Sales_2 Order Position goes in the warehouse before being sent. (Customer Order created, Delviery Document created, Package_2 Created)
             Sales_2 Order Position  can be Intercompany Order Position or Customer Order Position 
             The granularity is one row per combination of Sales_2 Order Position + PackageSID becasue items from one position could be sent in more than one package.
             Tables is used to simplify (and enable higher frequency of) anlalysis like  how many Orders do not have Delivery Document created or Package_2 for example. ';
