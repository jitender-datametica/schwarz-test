CREATE TABLE IF NOT EXISTS ldl_data_etl.t_inventory_statistics_type_2 (
inv_stat_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the kind of stasticis value that is calculated for an inventory.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
inv_stat_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the kind of stasticis value that is calculated for an inventory.')
);