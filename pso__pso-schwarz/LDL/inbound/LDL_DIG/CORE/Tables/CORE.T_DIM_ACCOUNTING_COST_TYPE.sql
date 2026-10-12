/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_ACCOUNTING_COST_TYPE
   GENERATED FROM POWERDESIGNER ON Dienstag, 10. Mai 2022 10:30:19
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_ACCOUNTING_COST_TYPE (
   ACCT_COST_TYPE_CD                   VARCHAR(20)     NOT NULL COMMENT 'Unique identifier of the cost type',
   ACCT_COST_TYPE_NAME_EN              VARCHAR(100)    COMMENT 'Name (description) of the cost type in English',
   ACCT_COST_TYPE_NAME_DE              VARCHAR(100)    COMMENT 'Name (description) of the cost type in German',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_ACCOUNTING_COST_TYPE PRIMARY KEY (ACCT_COST_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'A minor dimension with cost type values (in accounting) - "Direct Cost"/ "Indirect Cost" / "Credit". Values are populated manually without source table';
