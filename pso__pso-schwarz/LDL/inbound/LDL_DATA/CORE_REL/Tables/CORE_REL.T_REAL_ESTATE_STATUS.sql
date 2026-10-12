CREATE TABLE core_rel.T_REAL_ESTATE_STATUS (
   real_estate_sid                     NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
   real_estate_status_categ_cd         VARCHAR(20)     NOT NULL COMMENT 'The code identifying the kind of status lifecycle for real estate objects.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   real_estate_status_cd               VARCHAR(20)     NOT NULL COMMENT 'The code identifying the lifecycle status for real estate objects. The status code is related to a given status category.',
   real_estate_status_reason_cd        VARCHAR(20)     COMMENT 'The code identifying the reason why the status of a real estate object has changed.',
   comment_txt                         VARCHAR(1000)   COMMENT 'A free text comment further detailing the status and/or the reason for the status change.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_REAL_ESTATE_STATUS PRIMARY KEY (real_estate_sid, real_estate_status_categ_cd, dwh_valid_from_tmsp) NOT ENFORCED
)  COMMENT= 'This entity tracks the lifecycle status of a real estate object.';