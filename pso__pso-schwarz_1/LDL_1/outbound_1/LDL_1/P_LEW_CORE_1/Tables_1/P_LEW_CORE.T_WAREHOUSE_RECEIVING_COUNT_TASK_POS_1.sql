/* --------------------------------------------------------------------------------
   DDL for table: t_warehouse_receiving_count_task_pos_1
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 11:47:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_warehouse_receiving_count_task_pos_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT.'),
wh_rcv_cnt_task_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate identifier to be created (country_1, warehouse, inbound delivery / TaskID and creation date is generally unique).'),
wh_rcv_cnt_task_pos_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Position code per receiving count task.'),
wh_loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse; FK auf LOCATION.'),
wh_docking_gate_nr STRING(100)
OPTIONS(description='Identifier of the docking gate at the warehouse where the transportation vehicle docks for loading and unloading.'),
item_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key ITEM_1 (eindeutig ueber alle Laender/Mandanten hinweg).'),
departure_sup_sid BIGNUMERIC(38,0) OPTIONS(description='Supplier_1 SID from where the receiving item_1 departed.'),
departure_wh_loc_sid BIGNUMERIC(38,0)
OPTIONS(description='Location_1 SID of the warehouse from where the receiving item_1 departed.'),
departure_store_loc_sid BIGNUMERIC(38,0)
OPTIONS(description='Location_1 SID of the store from where the receiving item_1 departed.'),
despatch_advice_id NUMERIC(28,0)
OPTIONS(description='Reference to a despatch advice, if a despatch advice technically has been used in the counting process.'),
pos_created_dt DATE OPTIONS(description='Date when the counting task position has been created.'),
pos_status_id BIGNUMERIC(38,0)
OPTIONS(description='Status_1 of the receiving count task position like GR posted, rejected, not valid, open, etc.'),
rcv_receipt_id BIGNUMERIC(38,0)
OPTIONS(description='ID of the generated item_1 receiving record (if an item_1 receiving record has been created).'),
item_rcv_dt DATE OPTIONS(description='Date of when the item_1 has been received (if an item_1 receiving has been created).'),
pallet_cnt BIGNUMERIC(38,0) OPTIONS(description='Count of pallets in the task position.'),
case_cnt BIGNUMERIC(38,0) OPTIONS(description='Count of cases in the task position.'),
case_per_pallet_cnt BIGNUMERIC(38,0) OPTIONS(description='Count of cases per pallet.'),
handling_unit_nr STRING(100) OPTIONS(description='Handling unit_1 identifier.'),
handling_unit_type_cd STRING(100) OPTIONS(description='Handling unit_1 type code.'),
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
PRIMARY KEY (wh_rcv_cnt_task_sid, wh_rcv_cnt_task_pos_nr) NOT ENFORCED
)
OPTIONS(description='Table contains position or line-wise data of the counting task / inbound delivery of the receiving pallet from suppliers, store returns, warehouse transfers to warehouses.             Source:             WAWI table T174_GinCount_1, T187_FV_Order, T1010_SSCC             EWM table /SCDL/DB_PROCI_I, /SCDL/DB_BPLOC, /SCDL/DB_REFDOC, /SCWM/ORDIM_C (TRART = 5/6)');