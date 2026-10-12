CREATE TABLE core_rel.T_LANGUAGE_2 (
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   lang_name                           VARCHAR(100)    NOT NULL COMMENT 'The name of the language in group language, i.e. in German.',
   dwh_created_tmsp                    TIMESTAMP_LTZ (9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ (9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_LANGUAGE PRIMARY KEY (lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the language, e.g. German, English, French ...';
