/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_LEGACY_CUSTOMER_RETURN_PACKAGE_SHIPMENT_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 4. September 2024 14:29:04
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_LEGACY_CUSTOMER_RETURN_PACKAGE_SHIPMENT_2 (
   CUST_ORDER_SID                      NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for customer order',
   CUST_ORDER_POS_NR                   NUMBER          NOT NULL COMMENT 'The particular position number of an item_2 in an order',
   CUST_ORDER_POS_SEQ_NR               NUMBER          NOT NULL COMMENT 'In case a customer returns items from the same order position (ex 5 hats) in two different steps (two separate returns, or one return with two different packages ...) this column will contain consecutive number for each return per customer order position.',
   CUST_ORDER_NR                       VARCHAR(20)     COMMENT 'The original order number of the source system',
   RETURN_PACK_SID                     NUMBER          COMMENT 'The unique identifier(surrogate key) for the package_2 of the return',
   PACK_TRACKING_NR                    VARCHAR(1000)   COMMENT 'ID, whcih links the shipment to customer with the actual package_2 and can also be searched for within the the carrier url',
   RETURN_PACK_TRACKING_NR             VARCHAR(100)    COMMENT 'ID, whcih links the shipment of the return (from customer to Lidl Digital) with the actual package_2 and can also be searched for within the the carrier url',
   RETURN_REQUEST_NR                   VARCHAR(20)     COMMENT 'Internal return request number, created by Lidl when a customer creates a return request.  Not every return request is turned into return order.',
   RETURN_REQUEST_POS_NR               NUMBER          COMMENT 'The particular position number of an item_2 in a return request ',
   CUST_ORDER_RETURN_SID               NUMBER          COMMENT 'The unique identifier (surrogate key) for return of customer order',
   CUST_ORDER_RETURN_NR                VARCHAR(20)     COMMENT 'An original return order number',
   CUST_ORDER_RETURN_POS_NR            NUMBER          COMMENT 'A number of an particular position ( product ) in an return order',
   REQUEST_CREATE_DT                   DATE            COMMENT 'Date when a return request is created by a customer',
   REAL_ARRIVAL_WH_DT                  DATE            COMMENT 'Date when a return is received and registed back in the warehouse. ',
   RETURN_WH_SID                       NUMBER          COMMENT 'The unique identifier (surrogate key) for the warehouse handling the return.',
   RETURN_WH_CD                        VARCHAR(5)      COMMENT 'A short  unique code for warehouse to which the return is sent',
   ORIGIN_COUNTRY_CD                   VARCHAR(5)      COMMENT 'The unique code for a country_2 from which the customer sends back the package_2(s) (according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France)',
   HAULER_SID                          NUMBER          COMMENT 'The unique identifier (surrogate key) for hauler',
   HAULER_NAME                         VARCHAR(100)    COMMENT 'The name by which the hauler is known',
   HAULER_PICKUP_REF_NR                VARCHAR(50)     COMMENT 'Reference created by Hauler (Carrier), when he issues a label and take the package_2 via Pickup',
   RETURN_SHIP_COST_NET_EUR_VAL        NUMBER(38, 5)   COMMENT 'Lidl costs for shipping and transport (Return process)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_LEGACY_CUSTOMER_RETURN_PACKAGE_SHIPMENT PRIMARY KEY (CUST_ORDER_SID, CUST_ORDER_POS_NR, CUST_ORDER_POS_SEQ_NR) NOT ENFORCED 
)  COMMENT = 'Legacy copy of a  fact table that contains one row for every package_2 of returned items sent back by a customer. Customer may place one order with one position for 5 T-shirts. Then they can return 2 t-shirts in one return package_2 and 2 more shirts in another return package. This table contains data from SAP which is no longer an active source system for this kind of data (replaced by carrier layer)';
