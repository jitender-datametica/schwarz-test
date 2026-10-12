CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_real_estate_replacement_type_2 (
real_estate_replacement_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how a real estate object can replace another object. There are two types of replacments: Recolations and demolition and a new construction.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
real_estate_replacement_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the way, how a real estate object can replace another object.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (real_estate_replacement_type_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the way, how a real estate object can replace another object. There are two types of replacments: Relocations and demolition and a new construction.');