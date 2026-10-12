CREATE OR REPLACE TABLE ldl_data_production_etl.t_product_type_2 (
prod_type_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the discriminator for products.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
prod_type_descr STRING(250) NOT NULL OPTIONS(description='A textual description for the discriminator for products.'),
PRIMARY KEY (prod_type_cd, lang_cd) NOT ENFORCED
);