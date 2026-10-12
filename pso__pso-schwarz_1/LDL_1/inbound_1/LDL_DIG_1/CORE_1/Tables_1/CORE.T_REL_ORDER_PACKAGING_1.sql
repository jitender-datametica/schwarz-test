/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_ORDER_PACKAGING_1
   GENERATED FROM POWERDESIGNER ON Montag, 12. August 2024 07:48:03
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_REL_ORDER_PACKAGING_1 (
   PACK_SID                            NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the package.',
   PACK_POS_NR                         VARCHAR(20)     NOT NULL COMMENT 'The position number of the package_1',
   PROD_VARIANT_SID                    NUMBER(38,0)    COMMENT 'The unique identifier (surrogate key) for the product variant',
   DELIVERY_ORDER_SID                  NUMBER          COMMENT 'The unique identifier (surrogate key) for delivery order ',
   DELIVERY_ORDER_POS_NR               NUMBER          COMMENT 'The particular position number of a position in an order',
   DELIVERY_ORDER_NR                   VARCHAR(20)     COMMENT 'The order number from the system that processes deliveries',
   CUST_ORDER_SID                      NUMBER(38,0)    COMMENT 'The unique identifier (surrogate key) for customer order',
   CUST_ORDER_POS_NR                   NUMBER(38,0)    COMMENT 'The particular position number of an item_1 in an order',
   CUST_ORDER_NR                       VARCHAR(20)     COMMENT 'The original order number of the source system',
   IC_ORDER_SID                        NUMBER          COMMENT 'The unique identifier (surrogate key) for intercompany order',
   IC_ORDER_POS_NR                     NUMBER          COMMENT 'The particular position number of an item_1 in an order',
   IC_ORDER_NR                         VARCHAR(20)     COMMENT 'The order number assigned to the intercompany sale order in the source system',
   DELIV_PROD_QTY                      NUMBER(38, 5)   COMMENT 'Quantity of a specific product within a specific package_1',
   DELIV_PROD_PRICE                    NUMBER(38, 5)   COMMENT 'Price of a specific product within a specifc package_1',
   DELIV_PROD_VAL                      NUMBER(38, 5)   COMMENT 'Value of a specific product within a specific package_1',
   PACK_ORDER_NR                       VARCHAR(20)     COMMENT 'The order number within warehouse system which tells which articles are part of which package_1',
   SHIP_COST_NET_EUR_VAL               NUMBER(38, 5)   COMMENT 'The shipping costs for Lidl Digital for each article included in a package_1 (Only Forward process)',
   DELIVERY_TO_POINT_OF_USE_FG         BOOLEAN         COMMENT 'Flag indicating if the product will be delivered to the point of use.',
   DELIVERY_PICK_UP_FOR_RECYCLING_FG   BOOLEAN         COMMENT 'Flag that the old device will be picked up with the delivery of the new',
   DELIVERY_LABEL_FOR_RECYCLING_FG     BOOLEAN         COMMENT 'Flag indicating that the customer will send the old device with a label. No pick-up.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_REL_ORDER_PACKAGING PRIMARY KEY (PACK_SID, PACK_POS_NR) NOT ENFORCED 
)  COMMENT = 'One order line contains several items ( for example 5 flower pots) can be send in one or several packages ( 2+3  flower pots) or be combined with items from other order lines in one package. Table contains both customer orders and IC orders.';
