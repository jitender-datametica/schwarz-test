CREATE TABLE core_rel.T_REAL_ESTATE_STATUS_TYPE (
   real_estate_status_categ_cd         VARCHAR(20)     NOT NULL COMMENT 'The code identifying the kind of status lifecycle for real estate objects.',
   real_estate_status_cd               VARCHAR(20)     NOT NULL COMMENT 'The code identifying the lifecycle status for real estate objects. The status code is related to a given status category.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   real_estate_status_descr            VARCHAR(250)    NOT NULL COMMENT 'A textual description for the lifecycle status for real estate objects.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_REAL_ESTATE_STATUS_TYPE PRIMARY KEY (real_estate_status_categ_cd, real_estate_status_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the lifecycle status for real estate objects. E.g. an object may be under contract, open, closed or terminated. There may be more than one lifecycle for a given real estate object, e.g. its status in the source system and its status according to business logic. The lifecycle is identified by the status category code. For a given status category, a real estate object has one status code.';
