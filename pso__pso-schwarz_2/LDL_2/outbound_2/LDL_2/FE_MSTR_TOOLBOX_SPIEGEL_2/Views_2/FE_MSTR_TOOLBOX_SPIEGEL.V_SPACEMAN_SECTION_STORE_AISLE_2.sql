/*
#----------------------------------------------------------------------------
# Description:
# This view provides the dedicated aisle information on section and store level.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_store_aisle_2 (spaceman_section_sid, client_id,
move_to_store_id, aisle, dwh_created, dwh_updated) AS SELECT DISTINCT SECSTORE.spaceman_section_sid,
 STORE.client_id,
 STORE.move_to_store_id,
  CASE
  WHEN SSA.aisle IS NULL
  THEN 'no data'
  ELSE SSA.aisle
  END AS aisle,
 SSA.dwh_created,
 SSA.dwh_updated
FROM ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_store_2 AS SECSTORE
 INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_org_store_merge_vges_2 AS STORE ON SECSTORE.loc_sid_store = STORE.store_id AND
   SECSTORE.client_id = STORE.client_id
 LEFT JOIN ldl_fe_mstr_toolbox_spiegel.t_spaceman_section_store_aisle_2 AS SSA ON SECSTORE.spaceman_section_sid = SSA.spaceman_section_sid
     AND STORE.move_to_store_id = SSA.move_to_store_id AND STORE.client_id = SSA.client_id;