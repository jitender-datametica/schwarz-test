/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_CUSTOMER_ORDER_LOYALTY_CLASSIFICATION
   GENERATED FROM POWERDESIGNER ON Dienstag, 30. April 2024 12:48:42
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_CUSTOMER_ORDER_LOYALTY_CLASSIFICATION (
   CUST_ORDER_SID                      NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) to identify last order that was placed by a customer before any point in time.',
   MASTER_CUST_SID                     NUMBER          COMMENT 'The unique identifier (surrogate key) for the master customer',
   CUST_LOYALTY_LIFECYCLE_CD           VARCHAR(5)      COMMENT 'The code that defines the loyalty lifecycle of the customer.',
   CUST_LOYALTY_CLASSIFICATION_CD      VARCHAR(5)      COMMENT 'Code identifying customer purchasing habits ( One-time buyer, Occasional Buyer, Loyal Customer)',
   SECOND_LAST_CUST_ORDER_SID          NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) to identify 2nd last order that was placed by a customer before any point in time.',
   THIRD_LAST_CUST_ORDER_SID           NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) to identify 3rd last order that was placed by a customer before any point in time.',
   FOURTH_LAST_CUST_ORDER_SID          NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) to identify 4th last order that was placed by a customer before any point in time.',
   CUST_ORDER_CREATE_TMSP              TIMESTAMP_TZ    COMMENT 'The timestamp when order was created in source ERP system ( is used in reporting)',
   SECOND_LAST_CUST_ORDER_CREATE_TMSP  TIMESTAMP_TZ    COMMENT 'The Timestamp when customer''s 2nd last order was created in source system.',
   THIRD_LAST_CUST_ORDER_CREATE_TMSP   TIMESTAMP_TZ    COMMENT 'The Timestamp when customer''s 3rd last order was created in source system.',
   FOURTH_LAST_CUST_ORDER_CREATE_TMSP  TIMESTAMP_TZ    COMMENT 'The Timestamp when customer''s 4th last order was created in source system.',
   DAYS_DIFF_ORDER_1_2_CNT             NUMBER          COMMENT 'Number of days between last and the 2nd last customer order.',
   DAYS_DIFF_ORDER_1_3_CNT             NUMBER          COMMENT 'Number of days between last and the 3rd last customer order.',
   DAYS_DIFF_ORDER_1_4_CNT             NUMBER          COMMENT 'Number of days between last and the 4th last customer order.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_FACT_CUSTOMER_ORDER_LOYALTY_CLASSIFICATION PRIMARY KEY (CUST_ORDER_SID) NOT ENFORCED 
)  COMMENT = 'Fact table - Transactional - Transaction - A fact table for all OS (Online Shop) orders from each master customer as well as their corresponding 3 orders (including order timestamps & calculated number of days between them) that might have been before that to determine the loyalty segmentation of the master customer.';
