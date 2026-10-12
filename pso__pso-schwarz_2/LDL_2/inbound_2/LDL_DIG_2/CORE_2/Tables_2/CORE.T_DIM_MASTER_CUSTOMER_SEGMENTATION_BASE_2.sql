/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_MASTER_CUSTOMER_SEGMENTATION_BASE_2
   GENERATED FROM POWERDESIGNER ON Montag, 20. November 2023 08:44:34
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_MASTER_CUSTOMER_SEGMENTATION_BASE_2 (
   MASTER_CUST_SID                     NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the master customer',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   CUST_GENDER_CD                      VARCHAR(20)     COMMENT 'The code for a gender of a customer ( M - Male , F - Female)',
   CUST_GENERATION_CD                  VARCHAR(50)     COMMENT 'The code for a customer generation',
   ZIP_SHORT_CD                        VARCHAR(100)    COMMENT 'This field holds a shortened version of the billing address_2 postcode. The last character (either digit or letter) is removed to avoid identification of a customer.',
   CITY_NAME                           VARCHAR(100)    COMMENT 'The city name',
   COUNTRY_NAME                        VARCHAR(100)    COMMENT 'A country_2 name',
   CUST_BIRTH_CY                       NUMBER          COMMENT 'The birth year of the customer',
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
   CONSTRAINT PK_T_DIM_MASTER_CUSTOMER_SEGMENTATION_BASE PRIMARY KEY (MASTER_CUST_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'A segmentation base for the master customer . Does not contain GDPR protected data.';
