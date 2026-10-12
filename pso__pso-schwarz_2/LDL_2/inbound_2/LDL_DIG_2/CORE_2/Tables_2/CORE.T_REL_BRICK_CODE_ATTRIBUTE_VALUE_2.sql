CREATE TABLE CORE.T_REL_BRICK_CODE_ATTRIBUTE_VALUE_2 (
   ATTR_CD                             VARCHAR(50)     NOT NULL COMMENT 'The code of the brickcode attribute. ',
   PROD_BRICK_CD                       VARCHAR(10)     NOT NULL COMMENT 'The Brickcode is a unique standardized code of all categories in the GS1 article categorization system on level 4 and is maintained for every article in SAP. ',
   VALUE_CD                            VARCHAR(50)     NOT NULL COMMENT 'Code that identifies the brickcode attribute value',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   ATTR_DESCR                          VARCHAR(250)    COMMENT 'Name of the brickcode attribute. Eg: Target Gender',
   VALUE_DESCR                         VARCHAR(250)    COMMENT 'Name of the brickcode attribute value. Possible example: Male',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',
   CONSTRAINT PK_T_REL_BRICK_CODE_ATTRIBUTE_VALUE PRIMARY KEY (ATTR_CD, PROD_BRICK_CD, VALUE_CD, DWH_VALID_TO_TMSP) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the list of additional attributes applicable to brickcode categories';
