CREATE TABLE core_rel.T_LANGUAGE_USAGE_TYPE_2 (
   lang_usg_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code identifying the way, how a language may be used. E.g. a language may be used as the official language, another one for price labels and yet another one for handheld devices.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   lang_usg_type_descr                 VARCHAR(250)    NOT NULL COMMENT 'A textual description for the way, how a language may be used. ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_LANGUAGE_USAGE_TYPE PRIMARY KEY (lang_usg_type_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the ways, how a language may be used. E.g. a language may be used as the official language, another one for price labels and yet another one for handheld devices.';
