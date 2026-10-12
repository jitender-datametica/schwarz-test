CREATE TABLE core_dim.T_DIM_WAREHOUSE_PURPOSE_2 (
   wh_purpose_cd                       VARCHAR(20)     NOT NULL COMMENT 'The code identifying the purpose of a warehouse.',
   wh_purpose_descr                    VARCHAR(250)    NOT NULL COMMENT 'A textual description for the purpose of a warehouse. (Description in group language, i.e. in German)',
   wh_purpose_descr_de                 VARCHAR(250)    COMMENT 'A textual description for the purpose of a warehouse. (Description in German)',
   wh_purpose_descr_en                 VARCHAR(250)    COMMENT 'A textual description for the purpose of a warehouse. (Description in English)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_WAREHOUSE_PURPOSE PRIMARY KEY (wh_purpose_cd) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the main purposes which a warehouse may serve. E.g. crossdock, import warehouse, etc.';
