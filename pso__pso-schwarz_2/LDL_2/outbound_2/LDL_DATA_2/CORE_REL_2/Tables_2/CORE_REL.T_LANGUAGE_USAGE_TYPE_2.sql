CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_language_usage_type_2 (
lang_usg_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how a language may be used. E.g. a language may be used as the official language, another one for price labels and yet another one for handheld devices.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
lang_usg_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the way, how a language may be used. '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (lang_usg_type_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the ways, how a language may be used. E.g. a language may be used as the official language, another one for price labels and yet another one for handheld devices.');