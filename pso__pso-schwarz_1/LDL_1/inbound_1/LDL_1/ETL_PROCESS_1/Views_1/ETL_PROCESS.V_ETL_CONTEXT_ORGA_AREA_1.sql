CREATE OR REPLACE VIEW ETL_PROCESS.V_ETL_CONTEXT_ORGA_AREA_1
AS
   SELECT client_id
   ,country_cd
   ,cluster_area_cd area_cd
   ,cluster_area_type area_grp_type
   ,cluster_type
   FROM ETL_PROCESS.T_CLIENT_CLUSTER_HIERARCHY_MAINDEF_1 
; 