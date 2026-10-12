CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_AGC_CLIENT_CLUSTER
AS
   select client_id,
   sap_cluster_cd,
   pos_cluster_cd,
   last_updated,
   last_load_id
from p_lew_process.t_agc_client_cluster
;