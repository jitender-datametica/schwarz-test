CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem_ac.v_pit_clients_1 (client_id, effective_client_id, luxembourg_fg) AS
SELECT client_id,
 effective_client_id,
 luxembourg_fg
FROM ldl_p_lew_mart_pit_onprem.t_pit_clients_1 AS CLIENTS;