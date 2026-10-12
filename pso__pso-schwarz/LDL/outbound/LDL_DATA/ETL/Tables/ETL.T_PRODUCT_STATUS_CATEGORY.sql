CREATE TABLE IF NOT EXISTS ldl_data_etl.t_product_status_category (
prod_status_categ_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the kind of status lifecycle for products.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
prod_status_categ_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the kind of status lifecycle for products.'),
PRIMARY KEY (prod_status_categ_cd, lang_cd) NOT ENFORCED
);