CREATE OR REPLACE VIEW ldl_p_lew_bil.v_aji_deliv_item_sig_fa_2 AS SELECT client_id,
 item_sid,
 sub_item_grp_sid_asis,
 foodaction_fg
FROM ldl_p_lew_bil.t_agg_deliv_base_2 AS A
GROUP BY client_id,
 item_sid,
 sub_item_grp_sid_asis,
 foodaction_fg;