/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_COST_CENTER_NAME_1
   GENERATED FROM POWERDESIGNER ON Freitag, 10. Februar 2023 11:37:01
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_COST_CENTER_NAME_1 (
   LANGUAGE_CD                         VARCHAR(5)      NOT NULL COMMENT 'Code to identify the language of the names',
   COST_CENTER_NR                      VARCHAR(20)     NOT NULL COMMENT 'Identifier of the Cost Center',
   CC_VALID_TO_DT                      DATE            NOT NULL COMMENT 'The date until which this Cost Center can be used in bookings',
   SHORT_NAME                          VARCHAR(100)    COMMENT 'Short description of the Cost Center',
   LONG_NAME                           VARCHAR(100)    COMMENT 'Long description of the Cost Center',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_COST_CENTER_NAME PRIMARY KEY (LANGUAGE_CD, COST_CENTER_NR, CC_VALID_TO_DT) NOT ENFORCED
 )  COMMENT= 'Table that contains the description in English and in German of the cost centers.';
