CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_dim_real_estate_replacement_type_2 (
real_estate_replacement_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how a real estate object can replace another object. There are two types of replacments: Relocations and demolition and a new construction.'),
real_estate_replacement_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the way, how a real estate object can replace another object. (Description in group language, i.e. in German)'),
real_estate_replacement_type_descr_de STRING(250)
OPTIONS(description='A textual description for the way, how a real estate object can replace another object. (Description in German)'),
real_estate_replacement_type_descr_en STRING(250)
OPTIONS(description='A textual description for the way, how a real estate object can replace another object. (Description in English)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (real_estate_replacement_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the way, how a real estate object can replace another object. There are two types of replacments: Relocations and demolition and a new construction.');