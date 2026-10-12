/* --------------------------------------------------------------------------------
   DDL for table: T_LANGUAGE_2
   generated from Powerdesigner on Montag, 6. Mai 2024 16:10:47
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LANGUAGE_2 (
   LANG_CD                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   LANG_NAME                           VARCHAR(100)    NOT NULL COMMENT 'The name of the language in group language, i.e. in German.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOB storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_T_LANGUAGE PRIMARY KEY (LANG_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - This minor entity defines the language, e.g. German, English, French ... - Source - Manual';
