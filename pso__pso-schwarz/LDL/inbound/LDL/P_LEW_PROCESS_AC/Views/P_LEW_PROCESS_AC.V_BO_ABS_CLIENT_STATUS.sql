CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_BO_ABS_CLIENT_STATUS
AS
   SELECT client_id,
   sap_cluster_cd
FROM p_lew_process.t_bo_abs_client_status
;