/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_PAYMENT_METHOD_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 8. August 2023 09:48:21
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CUSTOMER_PAYMENT_METHOD_2 (
   CUST_PAYM_METHOD_CD                 VARCHAR(5)      NOT NULL COMMENT 'The code for the payment methods ',
   CUST_PAYM_METHOD_DESCR              VARCHAR(250)    COMMENT 'A textual description for the payment methods',
   IS_SECURE_FG                        BOOLEAN         COMMENT 'Indicates if the payment method is considered secure',
   CUST_PAYM_METHOD_SHORT_NAME         VARCHAR(250)    COMMENT 'The short version of the payment methods in group language',
   CUST_PAYM_METHOD_NAME               VARCHAR(250)    COMMENT 'The full version of the payment methods in group language.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_CUSTOMER_PAYMENT_METHOD PRIMARY KEY (CUST_PAYM_METHOD_CD) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the payment methods available in a system';
