DROP TABLE IF EXISTS ldl_p_lew_mart_lead.t_agg_str_day_item_pch_1;
CREATE OR REPLACE TABLE ldl_p_lew_mart_lead.t_agg_str_day_item_pch_1 (
client_id INTEGER NOT NULL,
loc_sid_store INTEGER NOT NULL,
item_sid INTEGER NOT NULL,
pcwo_reason_id INTEGER NOT NULL,
sfotype_id INTEGER NOT NULL,
pch_bnl_switch_fg INTEGER NOT NULL,
dwh_cal_dt DATE NOT NULL,
val_price_change NUMERIC(29,5),
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id, dwh_cal_dt;