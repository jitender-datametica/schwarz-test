CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_mart_lead_t_item_prpty_lst_hst_2 (client_id, item_sid,
item_prpty_lst_id, dat_valid_from, dat_valid_to, item_prpty_lst_id_curr) AS SELECT client_id,
 item_sid,
 item_prpty_lst_id,
 dat_valid_from,
 dat_valid_to,
 item_prpty_lst_id_curr
FROM ldl_p_lew_mart_lead.t_item_prpty_lst_hst_2;