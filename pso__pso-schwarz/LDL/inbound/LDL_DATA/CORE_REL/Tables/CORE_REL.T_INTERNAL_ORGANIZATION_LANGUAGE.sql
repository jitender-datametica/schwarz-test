CREATE TABLE core_rel.T_INTERNAL_ORGANIZATION_LANGUAGE (
   int_org_sid                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
   lang_usg_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code identifying the way, how a language may be used. E.g. a language may be used as the official language, another one for price labels and yet another one for handheld devices.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_INTERNAL_ORGANIZATION_LANGUAGE PRIMARY KEY (lang_usg_type_cd, int_org_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'This entity tracks the language preferences for an internal organization. Depending on the purpose, different languages may be used.';
