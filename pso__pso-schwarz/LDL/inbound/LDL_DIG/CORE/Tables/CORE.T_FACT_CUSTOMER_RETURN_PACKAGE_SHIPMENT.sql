/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_CUSTOMER_RETURN_PACKAGE_SHIPMENT
   GENERATED FROM POWERDESIGNER ON Dienstag, 28. Februar 2023 14:39:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_CUSTOMER_RETURN_PACKAGE_SHIPMENT (
   CUST_ORDER_SID                      NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for customer order',
   CUST_ORDER_POS_NR                   NUMBER          NOT NULL COMMENT 'The particular position number of an item in an order',
   CUST_ORDER_POS_SEQ_NR               NUMBER          NOT NULL COMMENT 'In case a customer returns items from the same order position (ex 5 hats) in two different steps (two separate returns, or one return with two different packages ...) this column will contain consecutive number for each return per customer order position.',
   CUST_ORDER_NR                       VARCHAR(20)     COMMENT 'The original order number of the source system',
   RETURN_PACK_SID                     NUMBER          COMMENT 'The unique identifier(surrogate key) for the package of the return',
   PACK_TRACKING_NR                    VARCHAR(100)    COMMENT 'ID, whcih links the shipment to customer with the actual package and can also be searched for within the the carrier url',
   RETURN_PACK_TRACKING_NR             VARCHAR(100)    COMMENT 'ID, whcih links the shipment of the return (from customer to Lidl Digital) with the actual package and can also be searched for within the the carrier url',
   RETURN_REQUEST_NR                   VARCHAR(20)     COMMENT 'Internal Return Request Number, created by Lidl when a customer creates a Returnr Request.  Not every Return Request is turned into Return Order',
   RETURN_REQUEST_POS_NR               NUMBER          COMMENT 'The particular position number of an item in a return request ',
   CUST_ORDER_RETURN_SID               NUMBER          COMMENT 'The unique identifier (surrogate key) for return of customer order',
   CUST_ORDER_RETURN_NR                VARCHAR(20)     COMMENT 'An original return order number',
   CUST_ORDER_RETURN_POS_NR            NUMBER          COMMENT 'A number of an particular position ( product ) in an return order',
   REQUEST_CREATE_DT                   DATE            COMMENT 'Date when a return request is created by a customer',
   REAL_ARRIVAL_WH_DT                  DATE            COMMENT 'Date when a return is received and registed back in the warehouse. ',
   RETURN_WH_SID                       NUMBER          COMMENT 'The unique identifier (surrogate key) for the warehouse to which the return is sent',
   RETURN_WH_CD                        VARCHAR(5)      COMMENT 'A short  unique code for warehouse to which the return is sent',
   ORIGIN_COUNTRY_CD                   VARCHAR(5)      COMMENT 'The unique code for a country from which the customer sends back the package(s) (according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France)',
   HAULER_SID                          NUMBER          COMMENT 'The unique identifier (surrogate key) for hauler',
   HAULER_NAME                         VARCHAR(100)    COMMENT 'The name of the hauler (Carrier) used by the customer to sent back the shipment',
   HAULER_PICKUP_REF_NR                VARCHAR(50)     COMMENT 'Reference created by Hauler (Carrier), when he issues a label and take the package via Pickup',
   RETURN_SHIP_COST_NET_EUR_VAL        NUMBER(38, 5)   COMMENT 'The shipping costs for lidl digital for each article included in a package (only Return process)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_FACT_CUSTOMER_RETURN_PACKAGE_SHIPMENT PRIMARY KEY (CUST_ORDER_SID, CUST_ORDER_POS_NR, CUST_ORDER_POS_SEQ_NR) NOT ENFORCED
 )  COMMENT= 'A fact table that contains one row for every package of return items sent back by a customer. Customer may place one order with one position for 5 T-shirts. Then he/she can return 2 t-shirts in one return packaged and 2 more shirts in another return package. ';
