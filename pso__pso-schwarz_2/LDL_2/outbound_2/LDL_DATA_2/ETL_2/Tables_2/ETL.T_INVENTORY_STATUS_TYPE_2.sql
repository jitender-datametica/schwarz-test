CREATE TABLE IF NOT EXISTS ldl_data_etl.t_inventory_status_type_2 (
inv_status_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the lifecycle status_2 for inventory events.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
inv_status_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the lifecycle status_2 for inventory events.')
)
OPTIONS(description='This minor entity defines the lifecycle statuses for inventory events. E.g. an inventory may be in progress, ready for booking or booked.');