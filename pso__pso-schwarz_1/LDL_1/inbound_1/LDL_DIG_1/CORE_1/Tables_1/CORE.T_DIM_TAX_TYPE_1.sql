/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_TAX_TYPE_1
   GENERATED FROM POWERDESIGNER ON Freitag, 23. September 2022 12:52:57
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_TAX_TYPE_1 (
   TAX_TYPE_CD                         VARCHAR(5)      NOT NULL COMMENT 'The code identifying the tax type',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   TAX_TYPE_DESCR_EN                   VARCHAR(250)    COMMENT 'Text describing the tax code (in English)',
   TAX_TYPE_DESCR_DE                   VARCHAR(250)    COMMENT 'Text describing the tax code (in German)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',
   CONSTRAINT PK_T_DIM_TAX_TYPE PRIMARY KEY (TAX_TYPE_CD, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the tax types';
