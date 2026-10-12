CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_item_desc_act_2 (client_id, item_id, item_desc, orig_item_nr, language_id
) AS SELECT client_id,
 item_id,
 item_desc,
 orig_item_nr,
 language_id
FROM ldl_p_lew_mart_msi.t_itm_item_desc_act_2;