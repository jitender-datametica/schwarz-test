CREATE TABLE IF NOT EXISTS ldl_data_etl.t_cash_register_type_1 (
cash_register_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
cash_register_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the type of cash register. (standard cash register, self-checkout system, vending machine)'),
PRIMARY KEY (cash_register_type_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the cash register type. It distinguishes between standard cash registers, self-checkout systems and vending machines.');