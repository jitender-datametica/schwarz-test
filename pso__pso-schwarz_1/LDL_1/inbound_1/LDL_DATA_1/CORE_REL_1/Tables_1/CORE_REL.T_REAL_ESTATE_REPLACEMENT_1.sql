CREATE TABLE core_rel.T_REAL_ESTATE_REPLACEMENT_1 (
   real_estate_sid                     NUMERIC(38,0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
   replacement_real_estate_sid         NUMERIC(38,0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object which replaces the other object.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ (9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ (9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   real_estate_replacement_type_cd     VARCHAR(20)     NOT NULL COMMENT 'The code identifying the way, how a real estate object can replace another object. There are two types of replacments: Relocations and demolition and a new construction.',
   dwh_created_tmsp                    TIMESTAMP_LTZ (9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ (9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_REAL_ESTATE_REPLACEMENT PRIMARY KEY (real_estate_sid, replacement_real_estate_sid, dwh_valid_from_tmsp) NOT ENFORCED
)  COMMENT= 'This entity tracks the real estate object(s) which replace other objects.There are two types of replacments: Relocations and demolition and a new construction. (The type of replacement is defined by the replacement type code.)';
