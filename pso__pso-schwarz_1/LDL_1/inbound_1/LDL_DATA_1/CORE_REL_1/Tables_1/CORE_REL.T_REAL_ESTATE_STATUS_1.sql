CREATE TABLE core_rel.T_REAL_ESTATE_STATUS_1 (
   real_estate_sid                     NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
   real_estate_status_categ_cd         VARCHAR(20)     NOT NULL COMMENT 'The code identifying the kind of status_1 lifecycle for real estate objects.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   real_estate_status_cd               VARCHAR(20)     NOT NULL COMMENT 'The code identifying the lifecycle status_1 for real estate objects. The status_1 code is related to a given status_1 category.',
   real_estate_status_reason_cd        VARCHAR(20)     COMMENT 'The code identifying the reason why the status_1 of a real estate object has changed.',
   comment_txt                         VARCHAR(1000)   COMMENT 'A free text comment further detailing the status_1 and/or the reason for the status_1 change.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_REAL_ESTATE_STATUS PRIMARY KEY (real_estate_sid, real_estate_status_categ_cd, dwh_valid_from_tmsp) NOT ENFORCED
)  COMMENT= 'This entity tracks the lifecycle status_1 of a real estate object.';