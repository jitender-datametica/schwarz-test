/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_CUSTOMER_ORDER_WEB_TRACKING
   GENERATED FROM POWERDESIGNER ON Freitag, 8. Juli 2022 14:32:08
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_REL_CUSTOMER_ORDER_WEB_TRACKING (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country',
   WEB_APP_TYPE_NAME                   VARCHAR(100)    NOT NULL COMMENT 'Name of the web app/client type (iOS App / Android App / Mobile Web / Desktop Web ...) ',
   CUST_ORDER_NR                       VARCHAR(20)     NOT NULL COMMENT 'The original order number of the source system',
   CUST_ORDER_HASH_NR                  VARCHAR(2000)   COMMENT 'The hashed order number for web tracking',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated',
   DWH_SRC_FILE_NAME                   VARCHAR(1000)   COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_REL_CUSTOMER_ORDER_WEB_TRACKING PRIMARY KEY (WSHOP_CD, WEB_APP_TYPE_NAME, CUST_ORDER_NR) NOT ENFORCED
 )  COMMENT= 'The relation table to hold the mapping between original customer order number to hashed value of customer order from Big Query source for tracking';
