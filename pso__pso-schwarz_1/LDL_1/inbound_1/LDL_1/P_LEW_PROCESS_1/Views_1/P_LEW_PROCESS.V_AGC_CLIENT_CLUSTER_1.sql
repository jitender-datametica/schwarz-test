CREATE OR REPLACE VIEW P_LEW_PROCESS.V_AGC_CLIENT_CLUSTER_1
(
 client_id
,sap_cluster_cd
,last_updated
,last_load_id
)
AS
   SELECT
    client_id,
   sap_cluster_cd,
   last_updated,
   last_load_id
   FROM p_lew_process.t_agc_client_cluster_1
;