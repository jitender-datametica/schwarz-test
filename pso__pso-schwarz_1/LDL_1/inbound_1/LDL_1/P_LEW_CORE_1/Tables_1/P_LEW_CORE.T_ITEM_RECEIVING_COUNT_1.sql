CREATE TABLE P_LEW_CORE.T_ITEM_RECEIVING_COUNT_1 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   loc_sid_wh                          NUMBER(38,0)    NOT NULL COMMENT 'warehouse, foreign key on location_1',
   item_cnt_id                         NUMBER(38,0)    NOT NULL COMMENT 'row number of the source table  from WAWI (t174_gincount_1)',
   item_sid                            NUMBER(38,0)    COMMENT 'Surrogate Key ITEM_1 (eindeutig ueber alle Laender/Mandanten hinweg)',
   sup_sid                             NUMBER(38,0)    COMMENT 'Surrogate Key SUPPLIER_1',
   despatch_advice_id                  NUMBER(28,0)    COMMENT 'reference to a despatch advice, if a despatch advice technically has been used in the counting process',
   task_create_dt                      DATE            COMMENT 'date when the counting task has been created',
   rcv_cnt_status_id                   NUMBER(38,0)    COMMENT 'status_1 identifier of the counting and processing of the location_item_incoming row',
   rcv_receipt_id                      NUMBER(38,0)    COMMENT 'ID of the generated item_1 receiving record (if an item_1 receiving record has been created)',
   item_rcv_dt                         DATE            COMMENT 'date of the item_1 receiving (if an item_1 receiving has been created)',
   total_case_qty                      NUMBER(38,0)    COMMENT 'total number of counted package_1 units',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created         			TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated         			TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_ITEM_RECEIVING_COUNT PRIMARY KEY (item_cnt_id, loc_sid_wh)
       NOT enforced
)
COMMENT = '$Revision: 0000 $. table contains pallet counts from the get in process for stock delivered from suppliers to warehouses
          Source: WAWI table T174_GINCOUNT_1';