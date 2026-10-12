CREATE TABLE core_rel.T_OWNERSHIP_TYPE (
   ownership_type_cd                   VARCHAR(20)     NOT NULL COMMENT 'The code identifying the ownership type of a real estate object, i.e. if it has been bought or if it is rented.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   ownership_type_descr                VARCHAR(250)    NOT NULL COMMENT 'A textual description for the ownership type of a real estate object,',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_OWNERSHIP_TYPE PRIMARY KEY (ownership_type_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the ownership type of a real estate object, i.e. if it has been bought or if it is rented.';
