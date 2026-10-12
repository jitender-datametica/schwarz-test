CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_item_desc_2 (client_id, item_sid, dat_rec_start, dat_rec_end,
item_desc, orig_item_nr, language_id, load_id) AS SELECT client_id,
 item_sid,
 dat_rec_start,
 dat_rec_end,
 item_desc,
 orig_item_nr,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_item_desc_2;