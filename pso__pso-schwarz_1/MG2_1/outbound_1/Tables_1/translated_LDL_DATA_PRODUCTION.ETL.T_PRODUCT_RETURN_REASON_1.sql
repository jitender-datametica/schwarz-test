CREATE OR REPLACE TABLE ldl_data_production_etl.t_product_return_reason_1 (
prod_return_reason_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the reasons why a product was returend to the store.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
prod_return_reason_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the reasons why a product was returend to the store.'),
PRIMARY KEY (prod_return_reason_sid, lang_cd) NOT ENFORCED
);