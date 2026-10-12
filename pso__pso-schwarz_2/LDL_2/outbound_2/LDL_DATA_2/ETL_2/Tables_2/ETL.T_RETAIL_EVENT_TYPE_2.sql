CREATE TABLE IF NOT EXISTS ldl_data_etl.t_retail_event_type_2 (
retail_event_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for retail events.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
retail_event_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the subtype discriminator for retail events.'),
PRIMARY KEY (retail_event_type_cd, lang_cd) NOT ENFORCED
);