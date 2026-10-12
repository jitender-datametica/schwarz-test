create or replace view LDL_DATA_PRODUCTION.ETL_PROCESS.V_ETL_CONTEXT_ORGA_AREA(
	CLIENT_ID,
	COUNTRY_CD,
	AREA_CD,
	AREA_GRP_TYPE,
	CLUSTER_TYPE
) as
   SELECT client_id
   ,country_cd
   ,cluster_area_cd area_cd
   ,cluster_area_type area_grp_type
   ,cluster_type
   FROM ETL_PROCESS.T_CLIENT_CLUSTER_HIERARCHY_MAINDEF 
;