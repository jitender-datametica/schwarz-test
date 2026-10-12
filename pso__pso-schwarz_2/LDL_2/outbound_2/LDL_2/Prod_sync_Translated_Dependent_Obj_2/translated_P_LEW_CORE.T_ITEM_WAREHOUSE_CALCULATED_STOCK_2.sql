CREATE OR REPLACE TABLE ldl_p_lew_core.t_item_warehouse_calculated_stock_2 (
wh_loc_sid INTEGER NOT NULL
OPTIONS(description='Surrogate Key LOCATION_2 (eindeutig ueber alle Laender / Mandanten hinweg), foreign key on location_2 (here: warehouse).\n            Source: T1430_NFE_BOOKINGS.C1430_WHNR'),
item_sid INTEGER NOT NULL
OPTIONS(description='Surrogate Key ITEM.\n            Source: T1430_NFE_BOOKINGS.C1430_ITEMNR'),
cal_dt DATE NOT NULL
OPTIONS(description='Calender date for which the record applies.\n            Source: T1430_NFE_BOOKINGS.C1430_DATE'),
stored_case_qty NUMERIC(29,5)
OPTIONS(description='A calculated amount that represents the item_2 case quantity that was stored in the warehouse on that day for further use (Wareneinlagerung). It is calculated by subtracting the circulated case quantity (WU Lager) from total WH stock. Since it is a calculated quantity based on movement data, it can contain accounting errors, and may therefore deviate from physically counted quantities.\n            Source: T1430_NFE_BOOKINGS.C1430_NFE_QUANTITY'),
circulated_case_qty NUMERIC(29,5)
OPTIONS(description='A calculated amount that represents the part of the warehouse item_2 stock case quantity that is considered as having circulated or been moved (Warenumlauf) for this warehouse and day. Since it is a calculated quantity based on movement data, it can contain accounting errors, and may therefore deviate from physically counted quantities. The circulated quantity of a given day is calculated by taking the circulated quantity of the previous day (if it exists), adding store returns (store claims and misc returns), offset it by write-offs, warehouse transfers (marked as NF returns) and stock corrections, and subtracted by goods out. If the calculation result is negative then it is set to 0. If it is larger than the total warehouse quantity then it is set to the total WH stock (Total WH Stock >= Circ. Qty >= 0).\n            Source: T1430_NFE_BOOKINGS.C1430_WU_LAGER_QUANTITY'),
client_id INTEGER NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (wh_loc_sid, item_sid, cal_dt) NOT ENFORCED
)
OPTIONS(description='This table contains different calculated item_2 stock quantity metrics for warehouses, like goods in circulation / circulated item_2 stock (Warenumlauf) and stored goods (Wareneinlagerung). Data is written every day even if there were no changes. Aggregations may deviate from the entire warehouse stock of an item_2 (booking errors). Currently contains only non-food item_2 data.\n             Source: WaWi Table T1430_NFE_BOOKINGS');