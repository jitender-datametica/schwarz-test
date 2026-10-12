CREATE TABLE core_dim.T_DIM_INTERNAL_ORGANIZATION_STATUS_TYPE_2 (
   int_org_status_cd                   VARCHAR(20)     NOT NULL COMMENT 'The code for the lifecycle status_2 of an internal organization.',
   int_org_status_descr                VARCHAR(250)    NOT NULL COMMENT 'A textual description for the lifecycle status_2 of an internal organization in group language, i.e. in German.',
   int_org_status_descr_de             VARCHAR(250)    COMMENT 'A textual description for the lifecycle status_2 of an internal organization in German.',
   int_org_status_descr_en             VARCHAR(250)    COMMENT 'A textual description for the lifecycle status_2 of an internal organization in English.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_INTERNAL_ORGANIZATION_STATUS_TYPE PRIMARY KEY (int_org_status_cd) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the lifecycle status_2 for internal organizations, i.e. if the internal organization is active or inactive.';
