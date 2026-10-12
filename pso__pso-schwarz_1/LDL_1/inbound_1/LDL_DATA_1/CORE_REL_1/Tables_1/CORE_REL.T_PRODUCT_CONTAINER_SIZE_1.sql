CREATE TABLE CORE_REL.T_PRODUCT_CONTAINER_SIZE_1 (
   prod_container_size_cd              VARCHAR(20)     NOT NULL COMMENT 'The code identifying the size class for module containers. (XS, small / medium / large)',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   prod_container_size_descr           VARCHAR(250)    NOT NULL COMMENT 'A textual description for the size class for module containers.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PRODUCT_CONTAINER_SIZE PRIMARY KEY (prod_container_size_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the size of surface containers. There are three size classes: XS, small, medium and large.';
