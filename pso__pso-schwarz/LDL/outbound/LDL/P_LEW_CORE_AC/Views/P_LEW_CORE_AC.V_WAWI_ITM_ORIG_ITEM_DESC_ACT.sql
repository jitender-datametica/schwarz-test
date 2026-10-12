CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_orig_item_desc_act (client_id, orig_item_nr, dat_valid_from,
item_desc, language_id) AS SELECT client_id,
 orig_item_nr,
 dat_valid_from,
 item_desc,
 language_id
FROM ldl_p_lew_core.t_wawi_itm_orig_item_desc_act;