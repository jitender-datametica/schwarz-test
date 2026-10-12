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
 CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_SPACEMAN_SECTION_STORE_AISLE_1
(
    spaceman_section_sid
    ,client_id
    ,move_to_store_id
    ,aisle
    ,dwh_created
    ,dwh_updated
)
AS
SELECT DISTINCT secstore.spaceman_section_sid
     , store.client_id
     , store.move_to_store_id
     , CASE WHEN ssa.aisle IS NULL THEN 'no data' ELSE ssa.aisle END AS aisle
     , ssa.dwh_created
     , ssa.dwh_updated
FROM FE_MSTR_TOOLBOX_SPIEGEL.v_spaceman_section_store_1 secstore 
INNER JOIN FE_MSTR_TOOLBOX_SPIEGEL.v_org_store_merge_vges_1 store
  ON store.store_id = secstore.loc_sid_store
  AND store.client_id = secstore.client_id
LEFT OUTER JOIN FE_MSTR_TOOLBOX_SPIEGEL.t_spaceman_section_store_aisle_1 ssa 
  ON secstore.spaceman_section_sid = ssa.spaceman_section_sid 
 AND store.move_to_store_id = ssa.move_to_store_id 
 AND store.client_id = ssa.client_id;