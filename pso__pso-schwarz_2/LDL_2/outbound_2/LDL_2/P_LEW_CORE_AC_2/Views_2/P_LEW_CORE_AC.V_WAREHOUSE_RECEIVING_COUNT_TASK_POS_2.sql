CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_warehouse_receiving_count_task_pos_2 (client_id
OPTIONS(description='DWH-Mandant_2; FK auf CLIENT.'), wh_rcv_cnt_task_sid
OPTIONS(description='Surrogate identifier to be created (country_2, warehouse, inbound delivery / TaskID and creation date is generally unique).'),
wh_rcv_cnt_task_pos_nr OPTIONS(description='Position code per receiving count task.'), wh_loc_sid
OPTIONS(description='Warehouse; FK auf LOCATION.'), wh_docking_gate_nr
OPTIONS(description='Identifier of the docking gate at the warehouse where the transportation vehicle docks for loading and unloading.'),
item_sid OPTIONS(description='Surrogate Key ITEM_2 (eindeutig ueber alle Laender/Mandanten hinweg).'), departure_sup_sid
OPTIONS(description='Supplier_2 SID from where the receiving item_2 departed.'), departure_wh_loc_sid
OPTIONS(description='Location_2 SID of the warehouse from where the receiving item_2 departed.'), departure_store_loc_sid
OPTIONS(description='Location_2 SID of the store from where the receiving item_2 departed.'), despatch_advice_id
OPTIONS(description='Reference to a despatch advice, if a despatch advice technically has been used in the counting process.'),
pos_created_dt OPTIONS(description='Date when the counting task position has been created.'), pos_status_id
OPTIONS(description='Status_2 of the receiving count task position like GR posted, rejected, not valid, open, etc.'),
rcv_receipt_id
OPTIONS(description='ID of the generated item_2 receiving record (if an item_2 receiving record has been created).'),
item_rcv_dt OPTIONS(description='Date of when the item_2 has been received (if an item_2 receiving has been created).'),
pallet_cnt OPTIONS(description='Count of pallets in the task position.'), case_cnt
OPTIONS(description='Count of cases in the task position.'), case_per_pallet_cnt
OPTIONS(description='Count of cases per pallet.'), handling_unit_nr OPTIONS(description='Handling unit_2 identifier.'),
handling_unit_type_cd OPTIONS(description='Handling unit_2 type code.'), pallet_type_cd
OPTIONS(description='Pallet type code like EU, DD, etc.'), rejected_fg
OPTIONS(description='Flag for when pallets were rejected.'), order_record_id
OPTIONS(description='Order number: src_orig_supplier_nr (4 digits), date (DDMMYY, 6 digits) and counting version number (2 digits) for supllier - Date combination; Wawi: PO_NR.'),
case_size_qty OPTIONS(description='Case size quantity of the package_2 unit_2 (Kolli).'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `TABLE CONTAINS POSITION OR LINE-WISE DATA OF THE COUNTING TASK / INBOUND DELIVERY OF THE RECEIVING PALLET FROM SUPPLIERS, STORE RETURNS, WAREHOUSE TRANSFERS TO WAREHOUSES.SOURCE:WAWI TABLE T174_GINCOUNT_2, T187_FV_ORDER, T1010_SSCCEWM TABLE /SCDL/DB_PROCI_I, /SCDL/DB_BPLOC, /SCDL/DB_REFDOC, /SCWM/ORDIM_C (TRART = 5/6)`)
AS SELECT client_id,
 wh_rcv_cnt_task_sid,
 wh_rcv_cnt_task_pos_nr,
 wh_loc_sid,
 wh_docking_gate_nr,
 item_sid,
 departure_sup_sid,
 departure_wh_loc_sid,
 departure_store_loc_sid,
 despatch_advice_id,
 pos_created_dt,
 pos_status_id,
 rcv_receipt_id,
 item_rcv_dt,
 pallet_cnt,
 case_cnt,
 case_per_pallet_cnt,
 handling_unit_nr,
 handling_unit_type_cd,
 pallet_type_cd,
 rejected_fg,
 order_record_id,
 case_size_qty,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_warehouse_receiving_count_task_pos_2;