CREATE OR REPLACE TABLE ldl_data_production_etl.t_inventory_product_reason (
inv_prod_reason_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier for the reason why an inventory was initiated for a certain product.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
inv_prod_reason_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the reason why an inventory was initiated for a certain product.')
) OPTIONS(description='This minor entity defines the reason why an inventory was initiated for a certain product.');