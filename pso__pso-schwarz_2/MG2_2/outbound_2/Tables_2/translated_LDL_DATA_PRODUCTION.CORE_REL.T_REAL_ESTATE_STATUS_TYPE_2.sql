CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_real_estate_status_type_2 (
real_estate_status_categ_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the kind of status_2 lifecycle for real estate objects.'),
real_estate_status_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the lifecycle status_2 for real estate objects. The status_2 code is related to a given status_2 category.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
real_estate_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the lifecycle status_2 for real estate objects.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (real_estate_status_categ_cd, real_estate_status_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the lifecycle status_2 for real estate objects. E.g. an object may be under contract, open, closed or terminated. There may be more than one lifecycle for a given real estate object, e.g. its status_2 in the source system and its status_2 according to business logic. The lifecycle is identified by the status_2 category code. For a given status_2 category, a real estate object has one status_2 code.');