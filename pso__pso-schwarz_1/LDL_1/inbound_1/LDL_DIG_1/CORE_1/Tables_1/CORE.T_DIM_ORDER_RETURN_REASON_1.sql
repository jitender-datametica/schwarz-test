CREATE TABLE CORE.T_DIM_ORDER_RETURN_REASON_1 (
   ORDER_RETURN_REASON_CD              VARCHAR(5)      NOT NULL COMMENT 'The code for the reason code on return document level .( 401 - Leeres Paket, 104 - Artikel_1 unvollständig , etc)',
   ORDER_RETURN_REASON_DESCR           VARCHAR(250)    NOT NULL COMMENT 'The textual description for the sales_1 channel in group language.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_ORDER_RETURN_REASON PRIMARY KEY (ORDER_RETURN_REASON_CD) NOT ENFORCED
 )  COMMENT= 'Return reason code on return document level. Available for full and partial returns.( 401 - Leeres Paket, 104 - Artikel_1 unvollständig , etc)';