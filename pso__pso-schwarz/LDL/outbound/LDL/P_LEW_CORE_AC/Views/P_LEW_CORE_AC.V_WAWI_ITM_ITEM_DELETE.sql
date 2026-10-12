CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_item_delete (client_id, item_sid, status_item_delete,
dat_item_delete, item_closed_fg, dat_dayend, load_id) AS SELECT client_id,
 item_sid,
 status_item_delete,
 dat_item_delete,
 item_closed_fg,
 dat_dayend,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_item_delete;