/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_MDM_HIERARCHY_NODE
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_mdm_hierarchy_node (client_id, hier_node_sid, src_hierarchy_cd,
src_hier_node_path, hier_node_cd, hier_node_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_core_ac.v_mdm_hierarchy_node;