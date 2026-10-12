CREATE TABLE IF NOT EXISTS ldl_data_etl.t_product_container_class (
prod_container_class_cd STRING(20) NOT NULL
OPTIONS(description='The code distinguishing between module containers and surface containers.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
prod_container_class_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the product container class.')
);