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
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_ORG_ALL_STORE_MERGE_VGES
(
     client_id
    ,move_to_store_id 
    ,move_store_desc
    ,orig_store_nr
    ,dashboard_relevant_fg
)
AS
SELECT store.client_id
     , store.move_to_store_id 
     , store.move_store_desc
     , store.orig_store_nr
     , store.dashboard_relevant_fg
FROM   P_LEW_MART_MSI_AC.v_org_all_store_merge store
WHERE  store.aspect_id = 2;