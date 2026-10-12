CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_real_estate_status_reason_2 (
real_estate_status_reason_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the reason why the status_2 of a real estate object has changed.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
real_estate_status_reason_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the reason why the status_2 of a real estate object has changed.'),
real_estate_status_categ_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the kind of status_2 lifecycle for real estate objects.'),
real_estate_status_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the lifecycle status_2 for real estate objects. The status_2 code is related to a given status_2 category.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (real_estate_status_reason_cd, lang_cd) NOT ENFORCED
) OPTIONS(description='This minor entity defines the reasons why the status_2 of a real estate object has changed.');