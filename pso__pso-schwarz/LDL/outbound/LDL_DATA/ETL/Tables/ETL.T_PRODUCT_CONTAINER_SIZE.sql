CREATE TABLE IF NOT EXISTS ldl_data_etl.t_product_container_size (
prod_container_size_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the size class for module containers. (small / medium / large)'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
prod_container_size_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the size class for module containers.')
);