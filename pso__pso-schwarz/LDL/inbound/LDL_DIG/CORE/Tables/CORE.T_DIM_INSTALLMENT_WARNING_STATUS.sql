CREATE TABLE CORE.t_dim_installment_warning_status (
   install_warn_status_cd              NUMBER          NOT NULL COMMENT 'If an order position was not paid, warning status occurs. A warning status cannot decrease. The warning status increases as long as the payment is due',
   install_warn_status_descr           VARCHAR(250)    NOT NULL COMMENT 'The textual description for the warning status',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT pk_t_dim_installment_warning_status PRIMARY KEY (install_warn_status_cd)
   )COMMENT = 'This minor dimension defines the warning levels that are set if customer does not pay the instalment';
