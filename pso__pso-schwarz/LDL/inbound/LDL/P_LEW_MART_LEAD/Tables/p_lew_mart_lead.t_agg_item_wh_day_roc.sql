CREATE TABLE p_lew_mart_lead.t_agg_item_wh_day_roc
     (
client_id SMALLINT NOT NULL,
wh_loc_sid INTEGER NOT NULL,
wh_id INTEGER NOT NULL,
aspect_id INTEGER NOT NULL,
item_sid INTEGER NOT NULL,
dat_formdate DATE NOT NULL,
cy_week INTEGER NOT NULL,
cy_month INTEGER NOT NULL,
busyear INTEGER NOT NULL,
stock_slot_fg BYTEINT NOT NULL,
stock_case_size_fg BYTEINT NOT NULL,
qty_piece_five_weeks_fg BYTEINT NOT NULL,
qty_piece_vs_case_size_fg BYTEINT NOT NULL,
flags_combined CHAR(4) COLLATE 'en-ci',
qty_piece_stc_wh DECIMAL(18,4) NOT NULL,
qty_total_goodsout_avg_35_days DECIMAL(18,4) NOT NULL,
dwh_updated TIMESTAMP(6))
/**** WARNING: PERFORMANCE REVIEW - CLUSTER BY ****/
/*CLUSTER BY(RANGE_N(dat_formdate BETWEEN '2015-01-01' AND '2030-12-31' EACH INTERVAL '1 day' , NO RANGE), RANGE_N(client_id BETWEEN 1 AND 40 EACH 1 , NO RANGE))*/
;