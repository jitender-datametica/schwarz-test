CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_store_day_pick_deliv_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store_move_to BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
wh_id BIGNUMERIC(38,0) NOT NULL,
aspect_id BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
cy_month BIGNUMERIC(38,0),
cy_week BIGNUMERIC(38,0),
stc_slot_id BIGNUMERIC(38,0),
qty_ord_case NUMERIC(18,5),
qty_del_case NUMERIC(18,5),
order_cnt NUMERIC(18,5),
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id, dat_formdate;