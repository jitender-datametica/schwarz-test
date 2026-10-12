/* --------------------------------------------------------------------------------
   DDL for table: t_dim_packing_type_1
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_dim_packing_type_1 (
packing_type_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the way, how a product is packed.'),
packing_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the way how a product is packed in group language, i.e. in German.'),
packing_type_descr_de STRING(250)
OPTIONS(description='A textual description for the way how a product is packed in German.'),
packing_type_descr_en STRING(250)
OPTIONS(description='A textual description for the way how a product is packed in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (packing_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the ways how a product (item_1) can be packed. E.g. box, bag, tin, ...');