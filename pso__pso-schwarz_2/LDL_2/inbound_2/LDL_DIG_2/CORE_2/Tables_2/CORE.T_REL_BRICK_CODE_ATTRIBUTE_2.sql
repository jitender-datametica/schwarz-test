/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_BRICK_CODE_ATTRIBUTE_2
   GENERATED FROM POWERDESIGNER ON Freitag, 12. August 2022 12:25:55
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_REL_BRICK_CODE_ATTRIBUTE_2 (
   ATTR_CD                             VARCHAR(50)     NOT NULL COMMENT 'A brickcode_attribute has an internal and an external code.It is a numeric code that identifies the attribute.
            The external code is the attribute code.',
   PROD_BRICK_CD                       VARCHAR(10)     NOT NULL COMMENT 'The Brickcode is a unique standardized code of all categories in the GS1 article categorization system on level 4 and is maintained for every article in SAP. ',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   ATTR_DESCR                          VARCHAR(250)    COMMENT 'Name of the brickcode attribute. Eg: Target Gender',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',
   CONSTRAINT PK_T_REL_BRICK_CODE_ATTRIBUTE PRIMARY KEY (ATTR_CD, PROD_BRICK_CD, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the list of brickcode attributes that has internal and external codes';
