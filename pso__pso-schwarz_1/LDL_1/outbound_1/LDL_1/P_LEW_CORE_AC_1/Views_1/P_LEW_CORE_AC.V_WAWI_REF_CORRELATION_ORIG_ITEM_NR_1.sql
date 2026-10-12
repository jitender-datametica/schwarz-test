CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_correlation_orig_item_nr_1 (orig_item_nr, orig_item_desc, mis_login,
buyer_fg, buyer_short_desc, timestamp_fn, dat_dayend, load_id) AS SELECT orig_item_nr,
 orig_item_desc,
 mis_login,
 buyer_fg,
 buyer_short_desc,
 timestamp_fn,
 dat_dayend,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_correlation_orig_item_nr_1;