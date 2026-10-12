CREATE TABLE CORE.t_dim_delivery_blocked_reason (
   delivery_blocked_reason_cd          VARCHAR(5)      NOT NULL COMMENT 'The code with the reason why the delivery is blocked for the specific customer order.',
   delivery_blocked_reason_descr       VARCHAR(250)    NOT NULL COMMENT 'The textual description for the delivery block information',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT pk_t_dim_delivery_blocked_reason PRIMARY KEY (delivery_blocked_reason_cd)
   )COMMENT = 'This minor dimension defines the reasons why the order is blocked ';
