CREATE TABLE IF NOT EXISTS ldl_data_etl.t_product_retail_line_type_1 (
prod_retail_line_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for product retail lines.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
prod_retail_line_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the subtype discriminator for product retail lines.'),
PRIMARY KEY (prod_retail_line_type_cd, lang_cd) NOT ENFORCED
);