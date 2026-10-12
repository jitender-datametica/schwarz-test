/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_USER_WEB_TRACKING_2
   GENERATED FROM POWERDESIGNER ON Montag, 28. November 2022 13:00:59
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_USER_WEB_TRACKING_2 (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2',
   FULL_VISITOR_ID                     VARCHAR(500)    NOT NULL COMMENT 'The visitor id generated in big query',
   CLIENT_ID                           VARCHAR(500)    NOT NULL COMMENT 'The client id generated in google analytics',
   CUST_HASH_NR                        VARCHAR(2000)   NOT NULL COMMENT 'The hashed customer number for tracking',
   TRACKING_TOKEN_HASH_NR              VARCHAR(2000)   NOT NULL COMMENT 'The hashed string value of token id in email allowing the tracking of subscriber activities',
   USER_VISIT_DT                       DATE            NOT NULL COMMENT 'The date when the user visited the site',
   USER_VISIT_START_TMSP               TIMESTAMP_TZ    NOT NULL COMMENT 'The start timestamp when the user has visited the site',
   USER_CLICK_TYPE                     VARCHAR(250)    COMMENT 'The user click tracking type to identify if google ad/ facebook or google double click',
   USER_CLICK_ID                       VARCHAR(2000)   COMMENT 'The unique click identifier created as a tracking parameter',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated',
   DWH_SRC_FILE_NAME                   VARCHAR(1000)   COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_FACT_USER_WEB_TRACKING PRIMARY KEY (WSHOP_CD, FULL_VISITOR_ID, CLIENT_ID, CUST_HASH_NR, TRACKING_TOKEN_HASH_NR, USER_VISIT_DT, USER_VISIT_START_TMSP) NOT ENFORCED
 )  COMMENT= 'The fact table that holds the tracking information of the user on web';
