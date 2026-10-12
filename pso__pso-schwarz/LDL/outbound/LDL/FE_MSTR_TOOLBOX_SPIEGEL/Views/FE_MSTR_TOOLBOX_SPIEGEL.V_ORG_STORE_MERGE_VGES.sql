/*
#----------------------------------------------------------------------------
# Description:
# This view provides the connection between move_to_store and store_id.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#  1.0     25.03.2025      Simeon Nikoalaev         Added filter to remove closed stores outside of report time range
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_org_store_merge_vges (client_id, store_id, store_desc,
orig_store_nr, move_to_store_id, move_store_desc, dashboard_relevant_fg) AS SELECT client_id,
 store_id,
 store_desc,
 orig_store_nr,
 move_to_store_id,
 move_store_desc,
 dashboard_relevant_fg
FROM ldl_p_lew_mart_msi_ac.v_org_store_merge AS STORE
WHERE aspect_id = 2
 AND (dat_closing IS NULL OR dat_closing BETWEEN DATE_ADD(CURRENT_DATE, INTERVAL - 366 DAY) AND (CURRENT_DATE));