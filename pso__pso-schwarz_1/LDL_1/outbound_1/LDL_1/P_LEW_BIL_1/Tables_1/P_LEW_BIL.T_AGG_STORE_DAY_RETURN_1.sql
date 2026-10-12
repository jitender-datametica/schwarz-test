CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_agg_store_day_return_1 (
client_id BIGNUMERIC(38,0),
src_orig_store_nr BIGNUMERIC(38,0),
loc_sid_store BIGNUMERIC(38,0),
orig_wh_nr BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0),
src_subitemgrp_cd BIGNUMERIC(38,0),
dwh_cal_dt DATE,
return_reason_mark STRING(5),
ship_qty NUMERIC(18,5),
ship_val NUMERIC(18,5),
ship_net_val NUMERIC(18,5),
curr_iso_cd STRING(5)
) CLUSTER BY client_id, dwh_cal_dt;