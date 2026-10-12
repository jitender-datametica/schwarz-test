CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_store_day_itm_pick_deliv_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store BIGNUMERIC(38,0) NOT NULL,
orig_item_nr INTEGER NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
cy_month BIGNUMERIC(38,0),
cy_week BIGNUMERIC(38,0),
stc_slot_id BIGNUMERIC(38,0),
qty_del_case NUMERIC(18,5),
order_cnt NUMERIC(18,5)
) CLUSTER BY client_id, dat_formdate;