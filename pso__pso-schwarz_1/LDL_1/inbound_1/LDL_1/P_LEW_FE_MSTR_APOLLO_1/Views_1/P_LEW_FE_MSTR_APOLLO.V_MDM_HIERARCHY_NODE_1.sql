/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_MDM_HIERARCHY_NODE_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_APOLLO.V_MDM_HIERARCHY_NODE_1  
(
	client_id
	,hier_node_sid
	,src_hierarchy_cd
	,src_hier_node_path
	,hier_node_cd
	,hier_node_name
	,dwh_load_id
	,dwh_created
	,dwh_updated     
)
AS
    SELECT 
	client_id
	,hier_node_sid
	,src_hierarchy_cd
	,src_hier_node_path
	,hier_node_cd
	,hier_node_name
	,dwh_load_id
	,dwh_created
	,dwh_updated    

FROM P_LEW_CORE_AC.V_MDM_HIERARCHY_NODE_1  ;