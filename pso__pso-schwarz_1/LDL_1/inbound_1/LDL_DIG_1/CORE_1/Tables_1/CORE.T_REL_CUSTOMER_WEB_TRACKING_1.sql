/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_CUSTOMER_WEB_TRACKING_1
   GENERATED FROM POWERDESIGNER ON Freitag, 8. Juli 2022 13:26:39
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_REL_CUSTOMER_WEB_TRACKING_1 (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1',
   WEB_APP_TYPE_NAME                   VARCHAR(100)    NOT NULL COMMENT 'Name of the web app/client type (iOS App / Android App / Mobile Web / Desktop Web ...) ',
   CUST_NR                             VARCHAR(20)     NOT NULL COMMENT 'The customer number from original system',
   CUST_ACCT_ID                        VARCHAR(100)    NOT NULL COMMENT 'The account_1 identifier which is SHA256 hash value to identify the SAP customer number',
   CUST_HASH_NR                        VARCHAR(2000)   COMMENT 'The hashed customer number for tracking',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated',
   DWH_SRC_FILE_NAME                   VARCHAR(1000)   COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_REL_CUSTOMER_WEB_TRACKING PRIMARY KEY (WSHOP_CD, WEB_APP_TYPE_NAME, CUST_NR, CUST_ACCT_ID) NOT ENFORCED
 )  COMMENT= 'The relation table to hold the mapping between original customer number to hashed value customer number from Big Query source for tracking';
