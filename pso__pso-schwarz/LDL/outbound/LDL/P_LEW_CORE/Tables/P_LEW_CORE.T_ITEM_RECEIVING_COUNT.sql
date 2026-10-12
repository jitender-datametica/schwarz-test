CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_receiving_count (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
loc_sid_wh BIGNUMERIC(38,0) NOT NULL OPTIONS(description='warehouse, foreign key on location'),
item_cnt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='row number of the source table  from WAWI (t174_gincount)'),
item_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key ITEM (eindeutig ueber alle Laender/Mandanten hinweg)'),
sup_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key SUPPLIER'),
despatch_advice_id NUMERIC(28,0)
OPTIONS(description='reference to a despatch advice, if a despatch advice technically has been used in the counting process'),
task_create_dt DATE OPTIONS(description='date when the counting task has been created'),
rcv_cnt_status_id BIGNUMERIC(38,0)
OPTIONS(description='status identifier of the counting and processing of the location_item_incoming row'),
rcv_receipt_id BIGNUMERIC(38,0)
OPTIONS(description='ID of the generated item receiving record (if an item receiving record has been created)'),
item_rcv_dt DATE OPTIONS(description='date of the item receiving (if an item receiving has been created)'),
total_case_qty BIGNUMERIC(38,0) OPTIONS(description='total number of counted package units'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_cnt_id, loc_sid_wh) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. table contains pallet counts from the get in process for stock delivered from suppliers to warehouses          Source: WAWI table T174_GINCOUNT');