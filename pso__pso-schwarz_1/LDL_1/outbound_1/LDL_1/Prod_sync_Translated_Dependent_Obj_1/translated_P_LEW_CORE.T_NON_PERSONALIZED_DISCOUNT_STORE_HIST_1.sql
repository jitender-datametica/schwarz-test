CREATE OR REPLACE TABLE ldl_p_lew_core.t_non_personalized_discount_store_hist_1 (
client_id INTEGER NOT NULL OPTIONS(description='unique identifier of the DWH client / slice.'),
np_discount_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key of the non personalized discount.'),
store_loc_sid INTEGER NOT NULL
OPTIONS(description='Surrogate Key LOCATION_1 (eindeutig ueber alle Laender / Mandanten hinweg).'),
deleted_fg INTEGER NOT NULL
OPTIONS(description='relation was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (np_discount_sid, store_loc_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='This tables contains the Store for which the non-personalized promotion is valid.(historised version).');