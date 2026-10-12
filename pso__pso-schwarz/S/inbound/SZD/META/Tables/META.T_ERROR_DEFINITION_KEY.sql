/* --------------------------------------------------------------------------------
   DDL for table: T_ERROR_DEFINITION_KEY
   generated from Powerdesigner on Montag, 27. November 2023 10:12:54
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_ERROR_DEFINITION_KEY (
   ERROR_DEFINITION_SID                NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the error definition',
   ERROR_DEFINITION_KEY_TYPE_CD        VARCHAR(50)     NOT NULL COMMENT 'The code for the type of natural key which identifies the error definition.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   ERROR_DEFINITION_NAT_KEY_NR         VARCHAR(250)    NOT NULL COMMENT 'The natural key which identifies the error definition. In case the natural key consist of several columns, all components get concatenated.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',   
   CONSTRAINT PK_T_ERROR_DEFINITION_KEY PRIMARY KEY (ERROR_DEFINITION_KEY_TYPE_CD, DWH_VALID_FROM_TMSP, ERROR_DEFINITION_NAT_KEY_NR) NOT ENFORCED 
)  COMMENT = 'Metadata - Keytable - Error Definition - Contains the mapping between surrogate keys and natural keys for business objects for "Error Definitions"  from the subject area "Common ".';
