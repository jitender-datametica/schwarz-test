CREATE TABLE IF NOT EXISTS ldl_data_etl.t_customer_identification_type_2 (
cust_ident_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way how the customer identifies himself in the store, e.g. by his loyalty card.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
cust_ident_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the way how the customer identifies himself in the store, e.g. by his loyalty card.'),
PRIMARY KEY (cust_ident_type_cd, lang_cd) NOT ENFORCED
);