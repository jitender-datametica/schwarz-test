/* --------------------------------------------------------------------------------
   DDL FOR TABLE: CORE.T_DIM_ACCOUNTED_MODULE_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 3. Februar 2022 15:53:46
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_ACCOUNTED_MODULE_1 (
   ACCOUNTED_MODULE_CD                 VARCHAR(5)      NOT NULL COMMENT 'Unique identifier of the module from which a real-world document originates, and then is booked by accounting document',
   MODULE_NAME_EN                      VARCHAR(100)    COMMENT 'Name of the module in English',
   MODULE_NAME_DE                      VARCHAR(100)    COMMENT 'Name of the module in German',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_ACCOUNTED_MODULE PRIMARY KEY (ACCOUNTED_MODULE_CD)
       NOT ENFORCED
)COMMENT = 'An "accounted module" is a module of the source system in which a real-world document is created (like logistics document) and then for this document we create accounting document(s).';
