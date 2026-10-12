CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_item_prpty_lst_1 (client_id, item_sid, item_prpty_lst_id, dat_valid_from,
dat_valid_to, item_prpty_lst_id_curr) AS SELECT client_id,
 item_sid,
 item_prpty_lst_id,
 dat_valid_from,
 dat_valid_to,
 item_prpty_lst_id_curr
FROM ldl_p_lew_mart_lead.t_item_prpty_lst_hst_1
WHERE dat_valid_to = PARSE_DATE('%F', '9999-12-30');