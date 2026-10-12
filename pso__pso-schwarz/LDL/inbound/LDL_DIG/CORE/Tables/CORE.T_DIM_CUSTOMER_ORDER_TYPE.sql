CREATE TABLE CORE.T_DIM_CUSTOMER_ORDER_TYPE (
   cust_order_type_cd                  VARCHAR(5)      NOT NULL COMMENT 'The unique code for the customer order type',
   cust_order_type_descr               VARCHAR(250)    NOT NULL COMMENT 'The textual description for the order type in group language',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_CUSTOMER_ORDER_TYPE PRIMARY KEY (cust_order_type_cd)

)COMMENT = 'This minor dimension defines the customer order type (B2B Orders, Replacement Order, etc)';