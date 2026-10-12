CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_warehouse_receiving_count_task_pos_fv_orders_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT.'),
wh_rcv_cnt_task_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate identifier to be created (country_2, warehouse, inbound delivery / TaskID and creation date is generally unique).'),
wh_loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse; FK auf LOCATION.'),
departure_sup_sid BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0),
fv_id NUMERIC(20,0) NOT NULL,
itemnr STRING(30),
krednr STRING(30),
created_date DATE,
row_status INTEGER,
rcv_id INTEGER,
qty_pal INTEGER,
qty INTEGER,
case_p_pal INTEGER,
pallet_type INTEGER,
sscc INTEGER,
casesize BIGNUMERIC(31,10),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (client_id, wh_loc_sid, wh_rcv_cnt_task_sid, fv_id) NOT ENFORCED
);