CREATE OR REPLACE TABLE ldl_data_production_etl.t_product_variant_relationship_type_1 (
prod_variant_rel_type_cd STRING(20) NOT NULL
OPTIONS(description='A code defining the way, how two product variants are related to each other.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
prod_variant_rel_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the way, how two product variants are related to each other.'),
PRIMARY KEY (prod_variant_rel_type_cd, lang_cd) NOT ENFORCED
);