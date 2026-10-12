CREATE OR REPLACE VIEW ldl_p_lew_bil.v_sfo_item_sig_fa_2 AS SELECT client_id,
 item_sid,
 sub_item_grp_sid_asis,
 foodaction_fg_asis
FROM ldl_p_lew_bil.t_agg_store_day_item_sfo_2 AS A
GROUP BY client_id,
 item_sid,
 sub_item_grp_sid_asis,
 foodaction_fg_asis;