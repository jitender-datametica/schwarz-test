CREATE OR REPLACE TABLE ldl_data_production_meta.t_wawi_item_variant_key_type (
wawi_item_variant_key_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the Wawi Item Variant.'),
wawi_item_variant_key_type_name STRING(100) NOT NULL
OPTIONS(description='The name of the type of natural key which identifies the Wawi Item Variant.'),
wawi_item_variant_key_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the type of natural key, detailing its format and the meaning of the components.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (wawi_item_variant_key_type_cd) NOT ENFORCED
) OPTIONS(description='This minor entity defines the type of natural key which identifies a Wawi Item Variant.');