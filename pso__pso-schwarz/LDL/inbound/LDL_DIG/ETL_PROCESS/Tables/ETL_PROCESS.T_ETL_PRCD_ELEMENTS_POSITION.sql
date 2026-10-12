CREATE TABLE ETL_PROCESS.T_ETL_PRCD_ELEMENTS_POSITION (
   prcd_elements_condition_nr          VARCHAR(20)     NOT NULL,
   cust_order_pos_nr                   NUMBER          NOT NULL,
   condition_counter                   NUMBER          NOT NULL,
   level_nr                            NUMBER          NOT NULL,
   condition_type                      VARCHAR(5),
   price_condition                     VARCHAR(2),
   price_condition_val                 NUMBER(38, 5),
   amount_val                          NUMBER(38, 5),
   curr_cd                             VARCHAR(5),
   lead_src_log_sys_cd                 VARCHAR(100)    COMMENT 'Technical field - source code',
   lead_src_name                       VARCHAR(100)    COMMENT 'Technical field - source name ',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   src_file_tmsp                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_PRCD_ELEMENTS_POSITIO PRIMARY KEY (prcd_elements_condition_nr, cust_order_pos_nr, condition_counter, level_nr)
)
COMMENT = 'ETL support table for pricing';