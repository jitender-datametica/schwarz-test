CREATE TABLE core_dim.T_DIM_WAREHOUSE_BUILDING_TYPE_2 (
   wh_building_type_cd                 VARCHAR(20)     NOT NULL COMMENT 'The code for the subtype discriminator for warehouse building.',
   wh_building_type_descr              VARCHAR(250)    NOT NULL COMMENT 'A textual description for the subtype discriminator for warehouse buildings. (Description in group language, i.e. in German)',
   wh_building_type_descr_de           VARCHAR(250)    COMMENT 'A textual description for the subtype discriminator for warehouse buildings. (Description in German)',
   wh_building_type_descr_en           VARCHAR(250)    COMMENT 'A textual description for the subtype discriminator for warehouse buildings. (Description in English)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_WAREHOUSE_BUILDING_TYPE PRIMARY KEY (wh_building_type_cd) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the subtype discriminator for warehouse building. It distinguishes between main warehouses and external warehouses.';
