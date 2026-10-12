CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_warehouse_receiving_count_task_pos_gincount_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT.'),
wh_rcv_cnt_task_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate identifier to be created (country_1, warehouse, inbound delivery / TaskID and creation date is generally unique).'),
wh_rcv_cnt_task_pos_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Position code per receiving count task.'),
wh_loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse; FK auf LOCATION.'),
wh_docking_gate_nr STRING(100)
OPTIONS(description='Identifier of the docking gate at the warehouse where the transportation vehicle docks for loading and unloading.'),
item_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key ITEM_1 (eindeutig ueber alle Laender/Mandanten hinweg).'),
po_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Supplier_1 SID from where the receiving item_1 departed.'),
despatch_advice_id NUMERIC(28,0)
OPTIONS(description='Reference to a despatch advice, if a despatch advice technically has been used in the counting process.'),
pos_created_dt DATE OPTIONS(description='Date when the counting task position has been created.'),
pos_status_id BIGNUMERIC(38,0)
OPTIONS(description='Status_1 of the receiving count task position like GR posted, rejected, not valid, open, etc.'),
rcv_receipt_id BIGNUMERIC(38,0)
OPTIONS(description='ID of the generated item_1 receiving record (if an item_1 receiving record has been created).'),
pallet_cnt BIGNUMERIC(38,0) OPTIONS(description='Count of pallets in the task position.'),
case_cnt BIGNUMERIC(38,0) OPTIONS(description='Count of cases in the task position.'),
case_per_pallet_cnt BIGNUMERIC(38,0) OPTIONS(description='Count of cases per pallet.'),
sscc STRING(100) OPTIONS(description='Handling unit_1 identifier.'),
pallet_type_cd STRING(100) OPTIONS(description='Pallet type code like EU, DD, etc.'),
rejected_fg BIGNUMERIC(38,0) OPTIONS(description='Flag for when pallets were rejected.'),
order_record_id STRING(100)
OPTIONS(description='Order number: src_orig_supplier_nr (4 digits), date (DDMMYY, 6 digits) and counting version number (2 digits) for supllier - Date combination; Wawi: PO_NR.'),
case_size_qty BIGNUMERIC(38,5) OPTIONS(description='Case size quantity of the package_1 unit_1 (Kolli).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (wh_rcv_cnt_task_sid, po_nr) NOT ENFORCED
)
OPTIONS(description='Table contains position or line-wise data of the counting task / inbound delivery of the receiving pallet from suppliers, store returns, warehouse transfers to warehouses.\n             Source:\n             WAWI table wh_move_egin_pos,');