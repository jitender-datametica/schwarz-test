CREATE TABLE IF NOT EXISTS ldl_data_etl.t_item_type_2 (
item_type_cd STRING(20) NOT NULL OPTIONS(description='The code for the subtype discriminator for items.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
item_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the subtype discriminator for items.'),
PRIMARY KEY (item_type_cd, lang_cd) NOT ENFORCED
);