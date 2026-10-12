/*
#-----------------------------------------------------------------------------
# Description:
# This table provides an inventory data with the granularity of store/day/item_sid
#
#-----------------------------------------------------------------------------
# History:
#  1.0     19.04.2024      Fikri Tekin			Added cluster key for large table in repository.
#  1.1     24.07.2025      Sanjay Agrawal		AP0265012: Added new column 'diff_inv_stc_calc_net_val_diff' for Inventurpreisdifferenz.
#
#-----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_agg_store_item_inv_all_1 (
client_id INTEGER NOT NULL,
st_loc_sid INTEGER NOT NULL,
inv_id INTEGER NOT NULL,
cy_month INTEGER NOT NULL,
dat_formdate DATE NOT NULL,
dat_valid_from DATE,
dat_valid_until DATE,
item_sid INTEGER NOT NULL,
val_rtl_ejr NUMERIC(18,5),
val_rtl_net_ejr NUMERIC(18,5),
val_return_ejr NUMERIC(18,5),
val_return_net_ejr NUMERIC(18,5),
qty_piece_ejr NUMERIC(18,5),
qty_return_ejr NUMERIC(18,5),
diff_inv_stc_calc_cnt NUMERIC(18,5),
diff_inv_stc_calc_val NUMERIC(18,5),
diff_inv_stc_calc_net_val NUMERIC(18,5),
diff_inv_stc_calc_net_val_diff BIGNUMERIC(38,5)
OPTIONS(description='high range due to column value for some country_1-items going out of representable range with (19,5)'),
val_abs NUMERIC(18,5),
val_net_abs NUMERIC(18,5),
val_pr_diff_del NUMERIC(18,5),
val_pr_diff_net_del NUMERIC(18,5),
val_pr_diff_return NUMERIC(18,5),
val_pr_diff_net_return NUMERIC(18,5),
val_pv NUMERIC(18,5),
val_net_pv NUMERIC(18,5),
val_claim NUMERIC(18,5),
val_claim_net NUMERIC(18,5),
foodaction_fg_asis INTEGER,
dwh_created DATETIME NOT NULL,
PRIMARY KEY (st_loc_sid, inv_id, dat_formdate, item_sid) NOT ENFORCED
) CLUSTER BY client_id, cy_month;