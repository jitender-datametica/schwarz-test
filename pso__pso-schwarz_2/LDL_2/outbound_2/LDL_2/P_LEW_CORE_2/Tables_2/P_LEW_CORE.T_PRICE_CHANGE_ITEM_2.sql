CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_price_change_item_2 (
client_id INTEGER NOT NULL,
loc_sid_store INTEGER NOT NULL,
loc_sid_wh INTEGER NOT NULL,
account_id INTEGER NOT NULL,
receipt_type_id INTEGER NOT NULL,
receipt_type_descr STRING(100),
price_change_debit_val NUMERIC(18,5),
price_change_debit_net_val NUMERIC(18,5),
price_change_credit_val NUMERIC(18,5),
price_change_credit_net_val NUMERIC(18,5),
dayend_dt DATE NOT NULL,
dwh_cal_dt DATE NOT NULL,
item_sid INTEGER,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);