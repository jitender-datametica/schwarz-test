/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup for move_to_store.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_org_all_store_merge_vges (client_id, move_to_store_id,
move_store_desc, orig_store_nr, dashboard_relevant_fg) AS SELECT client_id,
 move_to_store_id,
 move_store_desc,
 orig_store_nr,
 dashboard_relevant_fg
FROM ldl_p_lew_mart_msi_ac.v_org_all_store_merge AS STORE
WHERE aspect_id = 2;