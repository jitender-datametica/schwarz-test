CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_item_foodaction_asws_act_2 (client_id, item_sid, buying_list_type_id,
buying_list_type_desc, itemgroup_int_id, dat_valid) AS SELECT client_id,
 item_sid,
 buying_list_type_id,
 buying_list_type_desc,
 itemgroup_int_id,
 dat_valid
FROM ldl_p_lew_core.t_wawi_itm_item_foodaction_asws_act_2;