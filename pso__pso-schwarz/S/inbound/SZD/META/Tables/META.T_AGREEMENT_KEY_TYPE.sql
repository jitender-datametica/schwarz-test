/* --------------------------------------------------------------------------------
   DDL for table: T_AGREEMENT_KEY_TYPE
   generated from Powerdesigner on Freitag, 17. November 2023 09:41:34
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_AGREEMENT_KEY_TYPE (
   AGREEMENT_KEY_TYPE_CD               VARCHAR(50)     NOT NULL COMMENT 'The code for the type of natural key which identifies the agreement.',
   AGREEMENT_KEY_TYPE_NAME             VARCHAR(100)    NOT NULL COMMENT 'The name of the type of natural key which identifies the agreement.',
   AGREEMENT_KEY_TYPE_DESCR            VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type of natural key, detailing its format and the meaning of the components.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_AGREEMENT_KEY_TYPE PRIMARY KEY (AGREEMENT_KEY_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Metadata - Keytable - Agreement - Contains the types that shares the key space for the subject area "Agreement".';
