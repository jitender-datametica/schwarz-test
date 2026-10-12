CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_item_skey_act (client_id, item_sid, orig_item_nr, case_size,
reused_nr, dat_deleted, deleted_rmi_fg) AS SELECT client_id,
 item_sid,
 orig_item_nr,
 case_size,
 reused_nr,
 dat_deleted,
 deleted_rmi_fg
FROM ldl_p_lew_core.t_wawi_itm_item_skey_act;