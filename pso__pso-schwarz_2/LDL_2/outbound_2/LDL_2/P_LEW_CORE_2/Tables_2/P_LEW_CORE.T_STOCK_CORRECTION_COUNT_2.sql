CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_stock_correction_count_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
loc_sid_wh BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='warehouse, foreign key on location_2, in general the initiator of requests '),
request_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Inventory ID'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key ITEM_2 (eindeutig ueber alle Laender/Mandanten hinweg)'),
cnt_status_id BIGNUMERIC(38,0)
OPTIONS(description='status_2 of the counting of the item_2 from not counted, not valid article , counted, counted at store'),
act_item_cnt BIGNUMERIC(38,10)
OPTIONS(description='Calculated number of items at the day end based on the counted number of items as result of the counting request'),
calc_item_cnt BIGNUMERIC(38,10)
OPTIONS(description='calculated number of items at the day end based on the available data without the counting request results'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (request_id, loc_sid_wh) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. table contains counted items for counting requests for stores to correct item_2 related stock information;Source: WAWI table T438_PART_INV_DET');