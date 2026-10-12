CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_item_desc_act_1 (client_id, item_sid, item_desc, orig_item_nr,
language_id) AS SELECT client_id,
 item_sid,
 item_desc,
 orig_item_nr,
 language_id
FROM ldl_p_lew_core.t_wawi_itm_item_desc_act_1;