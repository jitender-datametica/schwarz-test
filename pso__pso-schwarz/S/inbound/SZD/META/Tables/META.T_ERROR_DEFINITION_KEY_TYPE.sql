/* --------------------------------------------------------------------------------
   DDL for table: T_ERROR_DEFINITION_KEY_TYPE
   generated from Powerdesigner on Freitag, 17. November 2023 10:40:37
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_ERROR_DEFINITION_KEY_TYPE (
   ERROR_DEFINITION_KEY_TYPE_CD        VARCHAR(50)     NOT NULL COMMENT 'The code for the type of natural key which identifies the error definition',
   ERROR_DEFINITION_KEY_TYPE_NAME      VARCHAR(100)    NOT NULL COMMENT 'The name of the type of natural key which identifies the error definition.',
   ERROR_DEFINITION_KEY_TYPE_DESCR     VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type of natural key, detailing its format and the meaning of the components.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',   
   CONSTRAINT PK_ERROR_DEFINITION_KEY_TYPE PRIMARY KEY (ERROR_DEFINITION_KEY_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Metadata - Keytable - Error Definition - Contains the types that shares the key space for the "Error Definition" in the subject area "Common".';
