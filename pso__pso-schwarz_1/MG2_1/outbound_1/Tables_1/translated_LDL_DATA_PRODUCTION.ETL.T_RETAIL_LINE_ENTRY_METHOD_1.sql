CREATE OR REPLACE TABLE ldl_data_production_etl.t_retail_line_entry_method_1 (
retail_line_entry_method_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how a retail line is entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
retail_line_entry_method_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the way, how a retail line is entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
PRIMARY KEY (retail_line_entry_method_cd, lang_cd) NOT ENFORCED
);