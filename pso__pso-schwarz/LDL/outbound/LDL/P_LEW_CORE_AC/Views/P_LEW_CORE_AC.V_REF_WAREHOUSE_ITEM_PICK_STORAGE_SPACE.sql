CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_warehouse_item_pick_storage_space (client_id
OPTIONS(description='DWH-Mandant; FK auf CLIENT'), wh_loc_sid OPTIONS(description='Warehouse; FK auf LOCATION.'),
item_sid OPTIONS(description='Artikel; FK auf ITEM; SAP-Retail: mard.matnr; SAP-BW: t_bw_z_ds_mard.matnr'),
wh_pick_storage_space_nr
OPTIONS(description='Picking storage space in the WH where the pallet is placed, e.g. bin, lane, door, etc.'),
deleted_fg
OPTIONS(description='Deleted flag (0/1) - here always 0, meaning that deleted records for stocks are removed (broken timeline history).'),
dwh_valid_from
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `The table contains information about picking places for each item. One item can be picked from various picking places. One picking place can be reused for different items over time.`)
AS SELECT client_id,
 wh_loc_sid,
 item_sid,
 wh_pick_storage_space_nr,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_warehouse_item_pick_storage_space;