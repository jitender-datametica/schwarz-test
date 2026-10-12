/* --------------------------------------------------------------------------------
   DDL for table: T_FINANCE_KEY_TYPE_2
   generated from Powerdesigner on Freitag, 9. Februar 2024 10:01:54
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_FINANCE_KEY_TYPE_2 (
   FINANCE_KEY_TYPE_CD                 VARCHAR(50)     NOT NULL COMMENT 'The code for the type of natural key which identifies the finance object.',
   FINANCE_KEY_TYPE_NAME               VARCHAR(100)    NOT NULL COMMENT 'The name of the type of natural key which identifies the finance object.',
   FINANCE_KEY_TYPE_DESCR              VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type of natural key, detailing its format and the meaning of the components.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_FINANCE_KEY_TYPE PRIMARY KEY (FINANCE_KEY_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Metadata - Keytable - Finance - Contains the types that shares the key space for the subject area "Finance".';
