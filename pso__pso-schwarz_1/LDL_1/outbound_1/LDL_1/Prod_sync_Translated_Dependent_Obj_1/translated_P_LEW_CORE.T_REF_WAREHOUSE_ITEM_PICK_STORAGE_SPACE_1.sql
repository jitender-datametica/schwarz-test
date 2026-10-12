CREATE OR REPLACE TABLE ldl_p_lew_core.t_ref_warehouse_item_pick_storage_space_1 (
client_id INTEGER NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
wh_loc_sid INTEGER NOT NULL OPTIONS(description='Warehouse; FK auf LOCATION.'),
item_sid INTEGER NOT NULL
OPTIONS(description='Artikel_1; FK auf ITEM_1; SAP-Retail: mard.matnr; SAP-BW: t_bw_z_ds_mard.matnr'),
wh_pick_storage_space_nr STRING(100) NOT NULL
OPTIONS(description='Picking storage space in the WH where the pallet is placed, e.g. bin, lane, door, etc.'),
deleted_fg INTEGER NOT NULL
OPTIONS(description='Deleted flag (0/1) - here always 0, meaning that deleted records for stocks are removed (broken timeline history).'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (wh_loc_sid, item_sid, wh_pick_storage_space_nr, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='The table contains information about picking places for each item. One item_1 can be picked from various picking places. One picking place can be reused for different items over time.');