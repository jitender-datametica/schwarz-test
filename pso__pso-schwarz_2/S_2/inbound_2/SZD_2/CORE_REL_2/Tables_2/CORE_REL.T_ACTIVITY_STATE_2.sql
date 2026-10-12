/* --------------------------------------------------------------------------------
   DDL for table: T_ACTIVITY_STATE_2
   generated from Powerdesigner on Montag, 11. November 2024 08:57:39
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_ACTIVITY_STATE_2 (
   ACTIVITY_STATE_ID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique id of the activity state.',
   ACTIVITY_STATE_NAME                 VARCHAR(100)    NOT NULL COMMENT 'The name of the activity state.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_ACTIVITY_STATE PRIMARY KEY (ACTIVITY_STATE_ID) NOT ENFORCED 
)  COMMENT = 'Minor Entity - An arbitrary activity state. - Source - Lexis';
