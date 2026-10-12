CREATE TABLE p_lew_process.t_wawi_sync_del_mov_item_wh_receiving_2 (
client_id SMALLINT NOT NULL,
wh_loc_sid INTEGER NOT NULL,
item_sid INTEGER NOT NULL,
stock_location_nr INTEGER,
receipt_id_rcv DECIMAL(15,0) NOT NULL,
UNIQUE ( client_id ,wh_loc_sid ,item_sid ,stock_location_nr ,
receipt_id_rcv)
);