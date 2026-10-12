CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_dim_brand_type_2 (
brand_type_cd STRING(20) NOT NULL
OPTIONS(description='A code that identifies the brand_2 type. (own brand_2 vs. private brand_2)'),
brand_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the brand_2 type (own brand_2 vs. private brand_2) in group language, i.e.in German.'),
brand_type_descr_de STRING(250)
OPTIONS(description='A textual description for the brand_2 type (own brand_2 vs. private brand_2) in German.'),
brand_type_descr_en STRING(250)
OPTIONS(description='A textual description for the brand_2 type (own brand_2 vs. private brand_2) in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (brand_type_cd) NOT ENFORCED
) OPTIONS(description='The brand_2 type distinguishes between own brands and private brands.');