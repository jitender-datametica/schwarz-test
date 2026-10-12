/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_GOODS_MOVEMENT_HEADER_2
   GENERATED FROM POWERDESIGNER ON Freitag, 24. Mai 2024 10:55:04
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_GOODS_MOVEMENT_HEADER_2 (
   WSHOP_CD                            VARCHAR(5)      COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2',
   DIST_CHANNEL_CD                     VARCHAR(5)      COMMENT 'The code for the distribution channel ( a channel  through which the goods are sold )',
   DELIVERY_ORDER_SID                  NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for delivery order ',
   DELIVERY_ORDER_NR                   VARCHAR(20)     NOT NULL COMMENT 'Delivery order number ',
   GOODS_MOV_CAT_CD                    VARCHAR(10)     COMMENT 'The code which identifies the reason why a product is moved out of the warehouse. E.g. delivery to a customer, return to a supplier_2, movement to another warehouse, ...',
   GOODS_MOV_ACTUAL_TMSP               TIMESTAMP_TZ(9) COMMENT 'The code for the category of goods movement',
   DELIVERY_TYPE_CD                    VARCHAR(5)      COMMENT 'The code for the delivery type',
   DELIVERY_ROUTE_CD                   VARCHAR(50)     COMMENT 'The code for the delivery route',
   SENDER_WH_CD                        VARCHAR(5)      COMMENT 'A short unique code for the warehouses which sends the deliveries.',
   DELIVERY_TGT_DT                     DATE            COMMENT 'The date which has been sent to the customer when the package_2 is meant to arrive the latest after he ordered something in the online shop successfully.',
   CUST_SID                            NUMBER          COMMENT 'The unique identifier (surrogate key) for the customer',
   WH_LEAVE_ACTUAL_TMSP                TIMESTAMP_TZ(9) COMMENT 'The timestamp when the truck actually left the warehouse platform (\"Rampe\") from which the package_2 is sent to the customer',
   WH_LEAVE_TGT_TMSP                   TIMESTAMP_TZ(9) COMMENT 'The timestamp when the truck is meant to leave for the specific tracking id. The time is known as CPT. The time depends on the warehouse, the carrier, the workday and the shipment type',
   DISTRIBUTION_STATUS_CD              VARCHAR(5)      COMMENT 'Code for the processing status_2 of the deliery in terms of decentralized Warehouse Management system processing',
   DISTRIBUTION_STATUS_NR              NUMBER          COMMENT 'Generated Number for the code for he processing status_2 of the deliery in terms of decentralized Warehouse Management system processing',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_GOODS_MOVEMENT_HEADER PRIMARY KEY (DELIVERY_ORDER_SID) NOT ENFORCED 
)  COMMENT = 'This transactional fact tracks packets that are going out of the warehouse. Includes Intercompany orders';
