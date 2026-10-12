DROP TABLE IF EXISTS ldl_p_lew_mart_lead.t_agg_store_day_pick_deliv_2;
CREATE OR REPLACE TABLE ldl_p_lew_mart_lead.t_agg_store_day_pick_deliv_2 (
client_id INTEGER NOT NULL,
loc_sid_store_move_to INTEGER NOT NULL,
wh_loc_sid INTEGER NOT NULL,
wh_id INTEGER NOT NULL,
aspect_id INTEGER NOT NULL,
dat_formdate DATE NOT NULL,
cy_month INTEGER,
cy_week INTEGER,
stc_slot_id INTEGER,
qty_del_case NUMERIC(29,5),
order_cnt NUMERIC(29,5),
dwh_updated DATETIME NOT NULL,
qty_ord_case NUMERIC(29,5)
) CLUSTER BY client_id, dat_formdate;