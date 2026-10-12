CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_BO_FLOP10_CLIENT_STATUS
AS
   SELECT client_id,
   sap_cluster_cd
FROM p_lew_process.t_bo_flop10_client_status
;