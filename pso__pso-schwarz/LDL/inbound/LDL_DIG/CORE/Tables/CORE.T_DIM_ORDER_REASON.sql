CREATE TABLE CORE.T_DIM_ORDER_REASON (
   ORDER_REASON_CD                     VARCHAR(5)      NOT NULL COMMENT 'Order reason code on order document level ( 008 guter Service ,etc)',
   ORDER_REASON_DESCR                  VARCHAR(250)    NOT NULL COMMENT 'The textual description for the order reason code in group language.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_ORDER_REASON PRIMARY KEY (ORDER_REASON_CD)
       NOT ENFORCED
)
COMMENT = 'Order reason code on order document level.';