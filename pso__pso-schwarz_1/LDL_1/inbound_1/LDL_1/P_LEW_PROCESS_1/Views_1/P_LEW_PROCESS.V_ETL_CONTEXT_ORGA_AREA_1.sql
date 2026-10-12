CREATE OR REPLACE VIEW P_LEW_PROCESS.V_ETL_CONTEXT_ORGA_AREA_1
AS
   -- Die Cluster für den POS-Loader müssen disjunkt zu den Clustern für SAP sein. In der Konfigtabelle wählen wir daher für alle POS-Cluster die Notation POS1-POSn
   SELECT client_id,
   country_cd,
   cluster_area_cd area_cd,
   cluster_area_type area_grp_type,
   cluster_type
  FROM p_lew_process.t_client_cluster_hierarchy_maindef_1
;