/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 16. Februar 2023 13:39:45
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CUSTOMER_2 (
   CUST_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the customer',
   CUST_TYPE_CD                        VARCHAR(5)      COMMENT 'The code for the customer type to differentiate whether an online shop or travel customer ',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   CUST_NR                             VARCHAR(20)     COMMENT 'A customer number from original system',
   CUST_ORG_TYPE_CD                    VARCHAR(5)      COMMENT 'The code for the customer organisation type (IND or ORG)',
   CUST_SALUTATION                     VARCHAR(100)    COMMENT 'The salutation of the customer',
   CUST_FIRST_NAME                     VARCHAR(100)    COMMENT 'The first name of the customer',
   CUST_LAST_NAME                      VARCHAR(100)    COMMENT 'The last name of the customer',
   CUST_BIRTH_DT                       DATE            COMMENT 'The birth date of the customer',
   CUST_COMPANY_NAME                   VARCHAR(100)    COMMENT 'Company name of the customer',
   CUST_BILLING_ADDR_SID               NUMBER          COMMENT 'The reference from the address_2 table for the latest billing address_2 of the customer',
   PHONE_NR                            VARCHAR(100)    COMMENT 'The phone number of the customer',
   EMAIL                               VARCHAR(100)    COMMENT 'The email address_2 of the customer',
   CUST_LAN_CD                         VARCHAR(5)      COMMENT 'Language chosen by the customer',
   CUST_SSO_ID                         VARCHAR(80)     COMMENT 'SSO id of the customer',
   CUST_BLOCKED_REASON_CD              VARCHAR(5)      COMMENT 'The code for the central order block via certain payment types for a customer',
   CUST_CREATION_DT                    DATE            COMMENT 'The creation date of the record of the customer in the database',
   CUST_REGISTRATION_DT                DATE            COMMENT 'The registration date of the customer in the platform',
   CUST_ACCT_ID                        VARCHAR(100)    COMMENT 'The account_2 identifier which is SHA256 hash value to identify the SAP customer number',
   IS_CUST_ADV_BLOCKED_FG              BOOLEAN         COMMENT 'The indicator to identify if a customer opted for advertisement mailings or not',
   EMAIL_PCU                           VARCHAR(100)    COMMENT 'Column added for comparison test_2 purpose between PCU and SAP src',
   PHONE_NR_PCU                        VARCHAR(100)    COMMENT 'Column added for comparison test_2 purpose between PCU and SAP src',
   CUST_SSO_ID_PCU                     VARCHAR(80)     COMMENT 'Column added for comparison test_2 purpose between PCU and SAP src',
   IS_CUST_BLOCKED_PCU_FG              BOOLEAN         COMMENT 'Column added for test_2 purpose -PCU source',
   IS_CUST_DELETED_PCU_FG              BOOLEAN         COMMENT 'Column added for test_2 purpose -PCU source',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',
   CONSTRAINT PK_T_DIM_CUSTOMER PRIMARY KEY (CUST_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'A person who buys products from Lidl webshops';
