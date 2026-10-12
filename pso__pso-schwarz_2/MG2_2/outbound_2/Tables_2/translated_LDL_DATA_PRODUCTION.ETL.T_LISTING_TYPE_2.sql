CREATE OR REPLACE TABLE ldl_data_production_etl.t_listing_type_2 (
list_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the listing type, e.g. regular assortment, seasonal products, promotional items, etc.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
list_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the listing type. E.g. regular assortment, seasonal products, promotional items, etc.'),
PRIMARY KEY (list_type_cd, lang_cd) NOT ENFORCED
);