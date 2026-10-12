CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_item_prpty_lst (client_id, item_sid, item_prpty_lst_id, dat_valid_from,
dat_valid_to, item_prpty_lst_id_curr) AS SELECT *
FROM ldl_p_lew_mart_lead.v_item_prpty_lst;