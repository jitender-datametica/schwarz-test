CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_BO_PERF_CLIENT_STATUS_1
AS
   SELECT client_id,
   sap_cluster_cd
FROM p_lew_process.t_bo_perf_client_status_1
;