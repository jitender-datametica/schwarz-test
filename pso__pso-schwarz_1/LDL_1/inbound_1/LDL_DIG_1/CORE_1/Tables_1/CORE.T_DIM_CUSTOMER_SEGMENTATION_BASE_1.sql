/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_SEGMENTATION_BASE_1
   GENERATED FROM POWERDESIGNER ON Montag, 20. November 2023 08:46:29
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CUSTOMER_SEGMENTATION_BASE_1 (
   CUST_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the customer',
   CUST_TYPE_CD                        VARCHAR(5)      COMMENT 'The code for the customer type to differentiate whether an online shop or travel customer ',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   CUST_GENDER_CD                      VARCHAR(20)     COMMENT 'The code for a gender of a customer ( M - Male , F - Female)',
   CUST_GENERATION_CD                  VARCHAR(50)     COMMENT 'The code for a customer generation',
   CUST_BIRTH_CY                       NUMBER          COMMENT 'The birth year of the customer',
   ZIP_SHORT_CD                        VARCHAR(100)    COMMENT 'This field holds a shortened version of the billing address_1 postcode. The last character (either digit or letter) is removed to avoid identification of a customer.',
   CITY_NAME                           VARCHAR(100)    COMMENT 'The city name',
   COUNTRY_NAME                        VARCHAR(100)    COMMENT 'A country_1 name',
   IS_BUSINESS_FG                      BOOLEAN         COMMENT 'A flag indicating that customer is a business',
   BUSINESS_TYPE_CD                    VARCHAR(50)     COMMENT 'The code for business type of the customer ',
   IS_USING_SSO_FG                     BOOLEAN         COMMENT 'True if customer is using single sign on login process',
   IS_CUST_DELETED_PCU_FG              BOOLEAN         COMMENT 'The indicator to identify if a customer is deleted (e.g. on customer demand or after certain period of inactivity)',
   IS_CUST_BLOCKED_PCU_FG              BOOLEAN         COMMENT 'The indicator to identify if a customer is blocked (e.g. due to multiple unsuccessful logins)',
   IS_CUST_ADV_BLOCKED_FG              BOOLEAN         COMMENT 'The indicator to identify if a customer opted for advertisement mailings or not',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',
   CONSTRAINT PK_T_DIM_CUSTOMER_SEGMENTATION_BASE PRIMARY KEY (CUST_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'A person who buys products from Lidl webshops - anonimised data to enable the segmentation';
