/* --------------------------------------------------------------------------------
   DDL for table: t_ref_order_change_source_1
   generated from Powerdesigner on Donnerstag, 19. Januar 2023 17:16:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_order_change_source_1 (
order_change_src_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID of the order change source: 1 = Internal change; 2 = External change; 3 = Other change.'),
order_change_src_descr STRING(250) OPTIONS(description='Description of the order change source'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last loading, which added or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp of the first insert of the record into the dwh.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the las update of the record in the dwh.'),
PRIMARY KEY (order_change_src_id) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the values of the order change sources.');