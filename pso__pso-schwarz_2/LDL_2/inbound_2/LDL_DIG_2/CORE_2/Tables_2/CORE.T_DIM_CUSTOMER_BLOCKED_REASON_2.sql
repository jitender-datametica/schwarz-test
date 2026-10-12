CREATE TABLE CORE.t_dim_customer_blocked_reason_2 (
   cust_blocked_reason_cd              VARCHAR(5)      NOT NULL COMMENT 'The code for the central order block via certain payment types for a customer',
   cust_blocked_reason_descr           VARCHAR(250)    NOT NULL COMMENT 'The description for the  central  order block via certain payment types for a customer',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT pk_t_dim_customer_blocked_reason PRIMARY KEY (cust_blocked_reason_cd)
   )COMMENT = 'This minor dimension defines the reasons why it is not allowed for the customer to place an order in SAP';
