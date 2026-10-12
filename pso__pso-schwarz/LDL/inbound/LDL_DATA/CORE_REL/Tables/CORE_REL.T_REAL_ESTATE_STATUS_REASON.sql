CREATE TABLE core_rel.T_REAL_ESTATE_STATUS_REASON (
   real_estate_status_reason_cd        VARCHAR(20)     NOT NULL COMMENT 'The code identifying the reason why the status of a real estate object has changed.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   real_estate_status_reason_descr     VARCHAR(250)    NOT NULL COMMENT 'A textual description for the reason why the status of a real estate object has changed.',
   real_estate_status_categ_cd         VARCHAR(20)     NOT NULL COMMENT 'The code identifying the kind of status lifecycle for real estate objects.',
   real_estate_status_cd               VARCHAR(20)     NOT NULL COMMENT 'The code identifying the lifecycle status for real estate objects. The status code is related to a given status category.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_REAL_ESTATE_STATUS_REASON PRIMARY KEY (real_estate_status_reason_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the reasons why the status of a real estate object has changed.';
