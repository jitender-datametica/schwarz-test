CREATE TABLE core_rel.T_REAL_ESTATE_REPLACEMENT_TYPE_2 (
   real_estate_replacement_type_cd     VARCHAR(20)     NOT NULL COMMENT 'The code identifying the way, how a real estate object can replace another object. There are two types of replacments: Recolations and demolition and a new construction.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   real_estate_replacement_type_descr  VARCHAR(250)    NOT NULL COMMENT 'A textual description for the way, how a real estate object can replace another object.',
   dwh_created_tmsp                    TIMESTAMP_LTZ (9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ (9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_REAL_ESTATE_REPLACEMENT_TYPE PRIMARY KEY (real_estate_replacement_type_cd, lang_cd) NOT ENFORCED
)  COMMENT= 'This minor entity defines the way, how a real estate object can replace another object. There are two types of replacments: Relocations and demolition and a new construction.';
