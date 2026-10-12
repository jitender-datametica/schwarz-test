CREATE TABLE CORE.t_dim_order_cancellation_reason_1 (
   order_cancel_reason_cd              VARCHAR(5)      NOT NULL COMMENT 'The reason code why the customer has cancelled or got been cancelled an order line/product',
   order_cancel_reason_descr           VARCHAR(250)    NOT NULL COMMENT 'The textual description of why the customer has cancelled an order line/product',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT pk_t_dim_order_cancellation_reason PRIMARY KEY (order_cancel_reason_cd)
   )COMMENT = 'This minor dimension defines the reasons why customer cancelled the order  ( Damaged product , Defect product ...etc.)';