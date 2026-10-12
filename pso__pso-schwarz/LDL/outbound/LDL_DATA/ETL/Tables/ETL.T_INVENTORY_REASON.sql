CREATE TABLE IF NOT EXISTS ldl_data_etl.t_inventory_reason (
inv_reason_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier for the reason why an inventory was initiated.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
inv_reason_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the reason why an inventory was initiated.')
) OPTIONS(description='This minor entity defines the reason why an inventory was initiated.');