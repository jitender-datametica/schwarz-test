CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_wh_move_item_receiving_count_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_wh BIGNUMERIC(38,0) NOT NULL,
item_cnt_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0),
despatch_advice_id BIGNUMERIC(38,0),
task_create_dt DATE,
rcv_cnt_status_id BIGNUMERIC(38,0),
rcv_receipt_id BIGNUMERIC(38,0),
total_case_qty BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
)
OPTIONS(description='$Revision: 0000 $. temporary cache table for loading into T_ITEM_RECEIVING_COUNT_1, source: WAWI table T174_GINCOUNT_1= wh_move_eGIN_pos');