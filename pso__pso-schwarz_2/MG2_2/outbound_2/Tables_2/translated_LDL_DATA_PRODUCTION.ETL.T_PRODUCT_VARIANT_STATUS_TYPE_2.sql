CREATE OR REPLACE TABLE ldl_data_production_etl.t_product_variant_status_type_2 (
prod_variant_status_type_cd STRING(20) NOT NULL
OPTIONS(description='The numeric identifier for the lifecycle status_2 for product variants.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
prod_variant_status_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the lifecycle status_2 for product variants.'),
PRIMARY KEY (prod_variant_status_type_cd, lang_cd) NOT ENFORCED
);