/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SUBSCRIBER_WEB_TRACKING
   GENERATED FROM POWERDESIGNER ON Dienstag, 14. Juni 2022 11:49:15
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_REL_SUBSCRIBER_WEB_TRACKING (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country',
   WEB_APP_TYPE_NAME                   VARCHAR(100)    NOT NULL COMMENT 'Name of the web app/client type (iOS App / Android App / Mobile Web / Desktop Web ...) ',
   TRACKING_TOKEN_NR                   VARCHAR(2000)   NOT NULL COMMENT 'A string that is inserted in email allowing the tracking of subscriber activities',
   TRACKING_TOKEN_HASH_NR              VARCHAR(2000)   COMMENT 'The hashed string value that is inserted in email allowing the tracking of subscriber activities',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated',
   DWH_SRC_FILE_NAME                   VARCHAR(1000)   COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_REL_SUBSCRIBER_WEB_TRACKING PRIMARY KEY (WSHOP_CD, WEB_APP_TYPE_NAME, TRACKING_TOKEN_NR) NOT ENFORCED
 )  COMMENT= 'The mapping table to hold the original token to hashed token number of subscriber for webtracking';
