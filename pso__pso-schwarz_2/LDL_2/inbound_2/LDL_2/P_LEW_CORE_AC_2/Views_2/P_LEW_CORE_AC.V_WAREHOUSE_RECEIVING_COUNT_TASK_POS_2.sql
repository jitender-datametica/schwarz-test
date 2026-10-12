CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_WAREHOUSE_RECEIVING_COUNT_TASK_POS_2 (
   client_id                                COMMENT 'DWH-Mandant_2; FK auf CLIENT.'
  ,wh_rcv_cnt_task_sid                      COMMENT 'Surrogate identifier to be created (country_2, warehouse, inbound delivery / TaskID and creation date is generally unique).'
  ,wh_rcv_cnt_task_pos_nr                   COMMENT 'Position code per receiving count task.'
  ,wh_loc_sid                               COMMENT 'Warehouse; FK auf LOCATION.'
  ,wh_docking_gate_nr                       COMMENT 'Identifier of the docking gate at the warehouse where the transportation vehicle docks for loading and unloading.'
  ,item_sid                                 COMMENT 'Surrogate Key ITEM_2 (eindeutig ueber alle Laender/Mandanten hinweg).'
  ,departure_sup_sid                        COMMENT 'Supplier_2 SID from where the receiving item_2 departed.'
  ,departure_wh_loc_sid                     COMMENT 'Location_2 SID of the warehouse from where the receiving item_2 departed.'
  ,departure_store_loc_sid                  COMMENT 'Location_2 SID of the store from where the receiving item_2 departed.'
  ,despatch_advice_id                       COMMENT 'Reference to a despatch advice, if a despatch advice technically has been used in the counting process.'
  ,pos_created_dt                           COMMENT 'Date when the counting task position has been created.'
  ,pos_status_id                            COMMENT 'Status_2 of the receiving count task position like GR posted, rejected, not valid, open, etc.'
  ,rcv_receipt_id                           COMMENT 'ID of the generated item_2 receiving record (if an item_2 receiving record has been created).'
  ,item_rcv_dt                              COMMENT 'Date of when the item_2 has been received (if an item_2 receiving has been created).'
  ,pallet_cnt                               COMMENT 'Count of pallets in the task position.'
  ,case_cnt                                 COMMENT 'Count of cases in the task position.'
  ,case_per_pallet_cnt                      COMMENT 'Count of cases per pallet.'
  ,handling_unit_nr                         COMMENT 'Handling unit_2 identifier.'
  ,handling_unit_type_cd                    COMMENT 'Handling unit_2 type code.'
  ,pallet_type_cd                           COMMENT 'Pallet type code like EU, DD, etc.'
  ,rejected_fg                              COMMENT 'Flag for when pallets were rejected.'
  ,order_record_id                          COMMENT 'Order number: src_orig_supplier_nr (4 digits), date (DDMMYY, 6 digits) and counting version number (2 digits) for supllier - Date combination; Wawi: PO_NR.'
  ,case_size_qty                            COMMENT 'Case size quantity of the package_2 unit_2 (Kolli).'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated                              COMMENT 'The point in time when this record was last updated.'
)
COMMENT = 'Table contains position or line-wise data of the counting task / inbound delivery of the receiving pallet from suppliers, store returns, warehouse transfers to warehouses.
Source:
WAWI table T174_GinCount_2, T187_FV_Order, T1010_SSCC
EWM table /SCDL/DB_PROCI_I, /SCDL/DB_BPLOC, /SCDL/DB_REFDOC, /SCWM/ORDIM_C (TRART = 5/6)'
AS SELECT
   client_id
  ,wh_rcv_cnt_task_sid
  ,wh_rcv_cnt_task_pos_nr
  ,wh_loc_sid
  ,wh_docking_gate_nr
  ,item_sid
  ,departure_sup_sid
  ,departure_wh_loc_sid
  ,departure_store_loc_sid
  ,despatch_advice_id
  ,pos_created_dt
  ,pos_status_id
  ,rcv_receipt_id
  ,item_rcv_dt
  ,pallet_cnt
  ,case_cnt
  ,case_per_pallet_cnt
  ,handling_unit_nr
  ,handling_unit_type_cd
  ,pallet_type_cd
  ,rejected_fg
  ,order_record_id
  ,case_size_qty
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_WAREHOUSE_RECEIVING_COUNT_TASK_POS_2
;