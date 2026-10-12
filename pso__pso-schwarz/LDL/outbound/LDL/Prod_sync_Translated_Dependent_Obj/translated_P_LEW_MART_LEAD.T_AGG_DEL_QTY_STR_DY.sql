DROP TABLE IF EXISTS ldl_p_lew_mart_lead.t_agg_del_qty_str_dy;
CREATE OR REPLACE TABLE ldl_p_lew_mart_lead.t_agg_del_qty_str_dy (
client_id INTEGER NOT NULL,
item_sid INTEGER NOT NULL,
loc_sid_store INTEGER NOT NULL,
dat_formdate DATE NOT NULL,
cy_month INTEGER NOT NULL,
busyear INTEGER NOT NULL,
del_qty_nfv_val NUMERIC(29,5),
del_qty_fv_val NUMERIC(29,5),
del_qty_brk_alc_val NUMERIC(29,5),
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id, dat_formdate;