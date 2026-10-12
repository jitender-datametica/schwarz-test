/* --------------------------------------------------------------------------------
   DDL FOR TABLE: CORE.T_DIM_LEDGER
   GENERATED FROM POWERDESIGNER ON Donnerstag, 3. Februar 2022 15:50:29
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_LEDGER (
   LEDGER_CD                           VARCHAR(5)      NOT NULL COMMENT 'Unique identifier of the financial Ledger',
   LEDGER_NAME_EN                      VARCHAR(100)    COMMENT 'Name of the ledger in English',
   LEDGER_NAME_DE                      VARCHAR(100)    COMMENT 'Name of the ledger in German',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_LEDGER PRIMARY KEY (LEDGER_CD)
       NOT ENFORCED
)COMMENT = 'A minor dimension that contains row for every ledger used for accounting in Lidl compnaies';
