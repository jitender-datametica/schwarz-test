CREATE OR REPLACE TABLE kfl_production_dbp_data.aad_engine_config (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land.'),
config_id INTEGER NOT NULL OPTIONS(description='Unique Identifier of the config setting'),
config_val INTEGER NOT NULL OPTIONS(description='Value of the config setting'),
config_descr STRING(255) OPTIONS(description='Describes the meaning of the config parameter in English'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, config_id) NOT ENFORCED
) OPTIONS(description='Contains configuration that the fraud detection model uses when processing data.');