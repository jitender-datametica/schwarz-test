CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_ownership_type_1 (
ownership_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the ownership type of a real estate object, i.e. if it has been bought or if it is rented.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
ownership_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the ownership type of a real estate object,'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (ownership_type_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the ownership type of a real estate object, i.e. if it has been bought or if it is rented.');