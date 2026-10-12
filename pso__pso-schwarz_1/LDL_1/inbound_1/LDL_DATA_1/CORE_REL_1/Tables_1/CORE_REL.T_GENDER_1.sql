CREATE TABLE core_rel.T_GENDER_1 (
   gender_cd                           VARCHAR(20)     NOT NULL COMMENT 'The code identifying the gender.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   gender_name                         VARCHAR(100)    NOT NULL COMMENT 'The name for the gender.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_GENDER PRIMARY KEY (gender_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the gender of a person. (i.e. male / female / ...)';
