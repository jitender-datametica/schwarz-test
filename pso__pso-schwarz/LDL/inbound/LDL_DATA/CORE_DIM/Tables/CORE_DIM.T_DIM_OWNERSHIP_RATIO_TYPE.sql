CREATE TABLE core_dim.T_DIM_OWNERSHIP_RATIO_TYPE (
   ownership_ratio_type_cd             VARCHAR(20)     NOT NULL COMMENT 'The code identifying the ownership ratio of a real estate object, i.e. if it is fully owned or partly owned.',
   ownership_ratio_type_descr          VARCHAR(250)    NOT NULL COMMENT 'A textual description for the ownership ratio of a real estate object, (Description in group language, i.e. in German)',
   ownership_ratio_type_descr_de       VARCHAR(250)    COMMENT 'A textual description for the ownership ratio of a real estate object, (Description in German)',
   ownership_ratio_type_descr_en       VARCHAR(250)    COMMENT 'A textual description for the ownership ratio of a real estate object, (Description in English)',
   dwh_created_tmsp                    TIMESTAMP_LTZ (9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ (9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_OWNERSHIP_RATIO_TYPE PRIMARY KEY (ownership_ratio_type_cd) NOT ENFORCED
)  COMMENT= 'This minor dimension defines the ownership ratio of a real estate object, i.e. if it is fully owned or partly owned.';
