CREATE TABLE CORE.t_dim_payment_settlement_type (
   paym_settl_type_cd                  VARCHAR(5)      NOT NULL COMMENT 'The code for the payment settlement type - how installment was paid',
   paym_settl_type_descr               VARCHAR(250)    NOT NULL COMMENT 'A textual description for the payment settlement type - how installment was paid',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT pk_t_dim_payment_settlement_type PRIMARY KEY (paym_settl_type_cd)
   )COMMENT = 'This minor dimension defines payment settlement type (Manual Posting , Reversal , etc )';
