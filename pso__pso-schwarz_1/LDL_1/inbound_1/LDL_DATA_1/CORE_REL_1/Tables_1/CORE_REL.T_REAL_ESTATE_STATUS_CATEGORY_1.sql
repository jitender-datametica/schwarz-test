CREATE TABLE core_rel.T_REAL_ESTATE_STATUS_CATEGORY_1 (
   real_estate_status_categ_cd         VARCHAR(20)     NOT NULL COMMENT 'The code identifying the kind of status_1 lifecycle for real estate objects.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   real_estate_status_categ_descr      VARCHAR(250)    NOT NULL COMMENT 'A textual description for the kind of status_1 lifecycle for real estate objects.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_REAL_ESTATE_STATUS_CATEGORY PRIMARY KEY (real_estate_status_categ_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the type of status_1 lifecycle for real estate objects. E.g. its status_1 in the source system and its status_1 according to business logic.';
