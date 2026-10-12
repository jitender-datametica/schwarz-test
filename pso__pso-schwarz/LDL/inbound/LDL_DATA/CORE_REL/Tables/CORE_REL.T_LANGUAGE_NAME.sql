CREATE TABLE core_rel.T_LANGUAGE_NAME (
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   display_lang_cd                     VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   lang_name                           VARCHAR(100)    NOT NULL COMMENT 'The name of the language in the language indicated by the display language code.',
   dwh_created_tmsp                    TIMESTAMP_LTZ (9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ (9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_LANGUAGE_NAME PRIMARY KEY (lang_cd, display_lang_cd) NOT ENFORCED
 )  COMMENT= 'This table provides the translations of the language names in multiple languages.';
