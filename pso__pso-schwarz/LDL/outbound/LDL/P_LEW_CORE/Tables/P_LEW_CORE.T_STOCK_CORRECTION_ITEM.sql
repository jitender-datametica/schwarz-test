/* --------------------------------------------------------------------------------
   DDL for table: t_stock_correction_item
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_stock_correction_item (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
loc_sid_wh BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='warehouse, foreign key on location, in general the initiator of requests '),
request_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Inventory ID'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key ITEM (eindeutig ueber alle Laender/Mandanten hinweg)'),
cnt_reason_id BIGNUMERIC(38,0) OPTIONS(description='id of the counting reason for stock correction requests'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (loc_sid_wh, request_id, item_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. table contains items for counting requests for stores to correct item related stock information;             Source: WAWI table T438_PART_INV_DET');