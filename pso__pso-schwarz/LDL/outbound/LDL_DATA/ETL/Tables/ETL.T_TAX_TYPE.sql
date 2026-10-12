CREATE TABLE IF NOT EXISTS ldl_data_etl.t_tax_type (
tax_type_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the kind of tax. (E.g. VAT)'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
tax_type_descr STRING(250) NOT NULL OPTIONS(description='A textual description for the kind of tax.'),
PRIMARY KEY (tax_type_cd, lang_cd) NOT ENFORCED
);