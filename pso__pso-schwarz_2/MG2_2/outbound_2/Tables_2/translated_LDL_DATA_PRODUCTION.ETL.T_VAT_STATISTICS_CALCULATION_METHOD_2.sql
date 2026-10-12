CREATE OR REPLACE TABLE ldl_data_production_etl.t_vat_statistics_calculation_method_2 (
vat_stat_calc_method_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how the VAT statistics have been calculated.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
vat_stat_calc_method_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the way, how the VAT statistics have been calculated.'),
PRIMARY KEY (vat_stat_calc_method_cd, lang_cd) NOT ENFORCED
);