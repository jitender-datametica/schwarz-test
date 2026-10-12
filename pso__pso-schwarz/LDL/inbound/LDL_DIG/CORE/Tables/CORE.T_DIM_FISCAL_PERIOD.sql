/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_FISCAL_PERIOD
   GENERATED FROM POWERDESIGNER ON Donnerstag, 5. Mai 2022 07:15:44
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_FISCAL_PERIOD (
   FISCAL_PERIOD_NR                    NUMBER          NOT NULL COMMENT 'Unique identifier of the fiscal period',
   FISCAL_PERIOD_NAME                  VARCHAR(100)    COMMENT 'Name (description) of the fiscal period',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_FISCAL_PERIOD PRIMARY KEY (FISCAL_PERIOD_NR) NOT ENFORCED
 )  COMMENT= 'A minor dimension fiscal periods used in accounting for a financial year';
