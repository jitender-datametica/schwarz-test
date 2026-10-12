CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_agg_store_day_return_1 (client_id, src_orig_store_nr, loc_sid_store, orig_wh_nr
, item_sid, src_subitemgrp_cd, dwh_cal_dt, return_reason_mark, ship_qty, ship_val, ship_net_val, curr_iso_cd) AS SELECT
 *
FROM ldl_p_lew_bil.v_agg_store_day_return_1;