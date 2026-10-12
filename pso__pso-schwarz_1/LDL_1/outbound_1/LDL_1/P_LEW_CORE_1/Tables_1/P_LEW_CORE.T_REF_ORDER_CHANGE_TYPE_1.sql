/* --------------------------------------------------------------------------------
   DDL for table: t_ref_order_change_type_1
   generated from Powerdesigner on Donnerstag, 19. Januar 2023 17:14:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_order_change_type_1 (
order_change_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID of the change type: 1 = Changed item_1 in order (quantity, date, time); 2 = Added item_1, 3 = deleted item.'),
order_change_type_descr STRING(250) OPTIONS(description='Description of the change type'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last loading, which added or updated the record.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp of the first insert of the record into the dwh.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the las update of the record in the dwh.'),
PRIMARY KEY (order_change_type_id) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the values of the order change types.');