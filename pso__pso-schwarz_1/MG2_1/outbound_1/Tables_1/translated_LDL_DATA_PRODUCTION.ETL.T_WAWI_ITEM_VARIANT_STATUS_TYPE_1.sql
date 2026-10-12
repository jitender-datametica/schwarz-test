CREATE OR REPLACE TABLE ldl_data_production_etl.t_wawi_item_variant_status_type_1 (
wawi_item_variant_status_type_id STRING(20) NOT NULL
OPTIONS(description='The identifier for the lifecycle status_1 for Wawi item_1 variants.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
wawi_item_variant_status_type_name STRING(250) NOT NULL
OPTIONS(description='The name for the lifecycle status_1 for Wawi item_1 variants.'),
wawi_item_variant_status_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the lifecycle status_1 for Wawi item_1 variants.'),
PRIMARY KEY (wawi_item_variant_status_type_id, lang_cd) NOT ENFORCED
);