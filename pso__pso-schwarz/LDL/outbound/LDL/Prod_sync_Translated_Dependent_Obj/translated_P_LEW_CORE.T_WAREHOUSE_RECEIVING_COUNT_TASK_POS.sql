CREATE OR REPLACE TABLE ldl_p_lew_core.t_warehouse_receiving_count_task_pos (
client_id INTEGER NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT.'),
wh_rcv_cnt_task_sid INTEGER NOT NULL
OPTIONS(description='Surrogate identifier to be created (country, warehouse, inbound delivery / TaskID and creation date is generally unique).'),
wh_rcv_cnt_task_pos_nr INTEGER NOT NULL OPTIONS(description='Position code per receiving count task.'),
wh_loc_sid INTEGER NOT NULL OPTIONS(description='Warehouse; FK auf LOCATION.'),
wh_docking_gate_nr STRING(100)
OPTIONS(description='Identifier of the docking gate at the warehouse where the transportation vehicle docks for loading and unloading.'),
item_sid INTEGER OPTIONS(description='Surrogate Key ITEM (eindeutig ueber alle Laender/Mandanten hinweg).'),
departure_sup_sid INTEGER OPTIONS(description='Supplier SID from where the receiving item departed.'),
departure_wh_loc_sid INTEGER
OPTIONS(description='Location SID of the warehouse from where the receiving item departed.'),
departure_store_loc_sid INTEGER OPTIONS(description='Location SID of the store from where the receiving item departed.'),
despatch_advice_id INTEGER
OPTIONS(description='Reference to a despatch advice, if a despatch advice technically has been used in the counting process.'),
pos_created_dt DATE OPTIONS(description='Date when the counting task position has been created.'),
pos_status_id INTEGER
OPTIONS(description='Status of the receiving count task position like GR posted, rejected, not valid, open, etc.'),
rcv_receipt_id INTEGER
OPTIONS(description='ID of the generated item receiving record (if an item receiving record has been created).'),
item_rcv_dt DATE OPTIONS(description='Date of when the item has been received (if an item receiving has been created).'),
pallet_cnt INTEGER OPTIONS(description='Count of pallets in the task position.'),
case_cnt INTEGER OPTIONS(description='Count of cases in the task position.'),
case_per_pallet_cnt INTEGER OPTIONS(description='Count of cases per pallet.'),
handling_unit_nr STRING(100) OPTIONS(description='Handling unit identifier.'),
handling_unit_type_cd STRING(100) OPTIONS(description='Handling unit type code.'),
pallet_type_cd STRING(100) OPTIONS(description='Pallet type code like EU, DD, etc.'),
rejected_fg INTEGER OPTIONS(description='Flag for when pallets were rejected.'),
order_record_id STRING(100)
OPTIONS(description='Order number: src_orig_supplier_nr (4 digits), date (DDMMYY, 6 digits) and counting version number (2 digits) for supllier - Date combination; Wawi: PO_NR.'),
case_size_qty NUMERIC(29,5) OPTIONS(description='Case size quantity of the package unit (Kolli).'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (wh_rcv_cnt_task_sid, wh_rcv_cnt_task_pos_nr) NOT ENFORCED
)
OPTIONS(description='Table contains position or line-wise data of the counting task / inbound delivery of the receiving pallet from suppliers, store returns, warehouse transfers to warehouses.\n             Source:\n             WAWI table T174_GinCount, T187_FV_Order, T1010_SSCC\n             EWM table /SCDL/DB_PROCI_I, /SCDL/DB_BPLOC, /SCDL/DB_REFDOC, /SCWM/ORDIM_C (TRART = 5/6)');