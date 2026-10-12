CREATE OR REPLACE TABLE ldl_data_production_etl.t_inventory_result_status_type_1 (
inv_result_status_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier for the counting status_1 of an inventory result. It shows, if the product could be counted.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
inv_result_status_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the counting status_1 of an inventory result. It shows, if the product could be counted.')
)
OPTIONS(description='This minor entity defines the counting status_1 of an inventory result. It shows, if the product could be counted.');