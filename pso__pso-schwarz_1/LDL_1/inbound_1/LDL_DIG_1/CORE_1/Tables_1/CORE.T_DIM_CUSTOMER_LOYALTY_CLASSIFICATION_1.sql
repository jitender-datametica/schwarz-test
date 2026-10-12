/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_LOYALTY_CLASSIFICATION_1
   GENERATED FROM POWERDESIGNER ON Montag, 24. Juli 2023 12:46:45
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CUSTOMER_LOYALTY_CLASSIFICATION_1 (
   CUST_LOYALTY_CLASSIFICATION_CD      VARCHAR(5)      NOT NULL COMMENT 'Code identifying customer purchasing habits ( One-time buyer, Occasional Buyer, Loyal Customer)',
   CUST_LOYALTY_CLASSIFICATION_DESCR   VARCHAR(250)    NOT NULL COMMENT 'Description of customer''s purchasing habits ( One-time buyer, Occasional Buyer, Loyal Customer)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_CUSTOMER_LOYALTY_CLASSIFICATION PRIMARY KEY (CUST_LOYALTY_CLASSIFICATION_CD) NOT ENFORCED
 )  COMMENT= 'This dimension describes the classification of the customer based on their bying habits (one-time, occasional, loyal ..)';
