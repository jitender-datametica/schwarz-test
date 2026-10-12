CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_warehouse_calculated_stock (wh_loc_sid
OPTIONS(description='Surrogate Key LOCATION (eindeutig ueber alle Laender / Mandanten hinweg), foreign key on location (here: warehouse).\nSource: T1430_NFE_BOOKINGS.C1430_WHNR'),
item_sid OPTIONS(description='Surrogate Key ITEM.\nSource: T1430_NFE_BOOKINGS.C1430_ITEMNR'), cal_dt
OPTIONS(description='Calender date for which the record applies.\nSource: T1430_NFE_BOOKINGS.C1430_DATE'),
stored_case_qty
OPTIONS(description='A calculated amount that represents the item case quantity that was stored in the warehouse on that day for further use (Wareneinlagerung). It is calculated by subtracting the circulated case quantity (WU Lager) from total WH stock. Since it is a calculated quantity based on movement data, it can contain accounting errors, and may therefore deviate from physically counted quantities.\nSource: T1430_NFE_BOOKINGS.C1430_NFE_QUANTITY'),
circulated_case_qty
OPTIONS(description='A calculated amount that represents the part of the warehouse item stock case quantity that is considered as having circulated or been moved (Warenumlauf) for this warehouse and day. Since it is a calculated quantity based on movement data, it can contain accounting errors, and may therefore deviate from physically counted quantities. The circulated quantity of a given day is calculated by taking the circulated quantity of the previous day (if it exists), adding store returns (store claims and misc returns), offset it by write-offs, warehouse transfers (marked as NF returns) and stock corrections, and subtracted by goods out. If the calculation result is negative then it is set to 0. If it is larger than the total warehouse quantity then it is set to the total WH stock (Total WH Stock >= Circ. Qty >= 0).\nSource: T1430_NFE_BOOKINGS.C1430_WU_LAGER_QUANTITY'),
client_id OPTIONS(description='DWH-Mandant; FK auf CLIENT'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `This table contains different calculated item stock quantity metrics for warehouses, like goods in circulation / circulated item stock (Warenumlauf) and stored goods (Wareneinlagerung). Data is written every day even if there were no changes. Aggregations may deviate from the entire warehouse stock of an item (booking errors). Currently contains only non-food item data.\nSource: WaWi Table T1430_NFE_BOOKINGS`)
AS SELECT wh_loc_sid,
 item_sid,
 cal_dt,
 stored_case_qty,
 circulated_case_qty,
 client_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_warehouse_calculated_stock;