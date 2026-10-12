CREATE OR REPLACE TABLE ldl_data_production_etl.t_wawi_item_key_type (
wawi_item_key_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the Wawi Item.'),
wawi_item_key_type_name STRING(100) NOT NULL
OPTIONS(description='The name of the type of natural key which identifies the Wawi Item.'),
wawi_item_key_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the type of natural key, detailing its format and the meaning of the components.'),
PRIMARY KEY (wawi_item_key_type_cd) NOT ENFORCED
) OPTIONS(description='This minor entity defines the type of natural key which identifies a Wawi Item.');