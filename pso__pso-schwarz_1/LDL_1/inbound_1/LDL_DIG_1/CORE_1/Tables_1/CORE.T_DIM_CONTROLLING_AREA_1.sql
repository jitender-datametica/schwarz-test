/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CONTROLLING_AREA_1
   GENERATED FROM POWERDESIGNER ON Freitag, 24. Februar 2023 12:02:21
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CONTROLLING_AREA_1 (
   CTRL_AREA_CD                        VARCHAR(5)      NOT NULL COMMENT 'A unique identifier of the Controlling Area',
   CTRL_AREA_DESCR                     VARCHAR(250)    COMMENT 'Description of the Controlling Area',
   CHART_OF_ACCOUNTS_CD                VARCHAR(5)      COMMENT 'Unique Identifier of the Chart of Accounts',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_CONTROLLING_AREA PRIMARY KEY (CTRL_AREA_CD) NOT ENFORCED
 )  COMMENT= 'A minor dimension that contains one row for ever controlling area used in accounting by Lidl compnaies';
