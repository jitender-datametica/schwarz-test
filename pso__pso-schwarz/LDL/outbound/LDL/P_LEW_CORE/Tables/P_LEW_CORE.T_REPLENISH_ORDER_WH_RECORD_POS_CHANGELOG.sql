/* --------------------------------------------------------------------------------
   DDL for table: t_replenish_order_wh_record_pos_changelog
   generated from Powerdesigner on Donnerstag, 19. Januar 2023 17:11:53
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_replenish_order_wh_record_pos_changelog (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique identifier of the DWH client / slice.'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key LOCATION (unique across all countries / clients).'),
order_record_id STRING(20) NOT NULL
OPTIONS(description='Order number: src_orig_supplier_nr (4 digits), date (DDMMYY, 6 digits) and counting version number (2 digits) for supllier - Date combination; Wawi: PO_NR'),
change_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Number of the version of the order position. Counts up, whenever a change is made to the delivery position.'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key ITEM (unique across all countries / clients).'),
old_order_qty BIGNUMERIC(38,5) OPTIONS(description='Order quantity of the article before the change.'),
new_order_qty BIGNUMERIC(38,5) OPTIONS(description='Order quantity of the article after the change.'),
old_order_deliv_dt DATE OPTIONS(description='Date of the delivery before the change.'),
new_order_deliv_dt DATE OPTIONS(description='Date of the delivery after the change.'),
old_order_deliv_tm TIME OPTIONS(description='Time of the delivery before the change'),
new_order_deliv_tm TIME OPTIONS(description='Time of the delivery after the change'),
mod_dt DATE OPTIONS(description='Date of the modification'),
order_change_type_id BIGNUMERIC(38,0)
OPTIONS(description='ID of the change type: 1 = Changed item in order (quantity, date, time); 2 = Added item, 3 = deleted item'),
order_change_src_id BIGNUMERIC(38,0)
OPTIONS(description='ID of the order change source: 1 = Internal change; 2 = External change; 3 = Other change'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last loading, which added or updated the record.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp of the first insert of the record into the dwh.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the las update of the record in the dwh.'),
PRIMARY KEY (loc_sid, order_record_id, change_seq, item_sid) NOT ENFORCED
)
OPTIONS(description='Changes of orders from a supplier to the warehouse on item / order position level.Wawi: T129_orderchangeslog');