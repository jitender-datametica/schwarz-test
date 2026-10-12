CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_dim_warehouse_building_type (
wh_building_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the subtype discriminator for warehouse building.'),
wh_building_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the subtype discriminator for warehouse buildings. (Description in group language, i.e. in German)'),
wh_building_type_descr_de STRING(250)
OPTIONS(description='A textual description for the subtype discriminator for warehouse buildings. (Description in German)'),
wh_building_type_descr_en STRING(250)
OPTIONS(description='A textual description for the subtype discriminator for warehouse buildings. (Description in English)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (wh_building_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the subtype discriminator for warehouse building. It distinguishes between main warehouses and external warehouses.');