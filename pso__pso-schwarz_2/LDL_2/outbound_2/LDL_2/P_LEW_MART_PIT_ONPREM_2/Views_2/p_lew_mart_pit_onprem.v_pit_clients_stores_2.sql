CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_clients_stores_2 (client_id, effective_client_id, store_sid,
store_grp_luxembourg_fg, orig_store_nr, store_name) AS SELECT client_id,
 effective_client_id,
 store_sid,
 store_grp_luxembourg_fg,
 orig_store_nr,
 store_name
FROM ldl_p_lew_mart_pit_onprem.t_pit_clients_stores_2 AS CSTORES;