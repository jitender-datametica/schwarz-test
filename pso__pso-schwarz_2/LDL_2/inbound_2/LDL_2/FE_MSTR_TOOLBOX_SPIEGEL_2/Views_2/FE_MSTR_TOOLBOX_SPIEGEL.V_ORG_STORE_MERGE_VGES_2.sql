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
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_ORG_STORE_MERGE_VGES_2
(
    client_id
    ,store_id
    ,store_desc
    ,orig_store_nr    
    ,move_to_store_id 
    ,move_store_desc 
    ,dashboard_relevant_fg
)
AS
SELECT store.client_id
     , store.store_id
     , store.store_desc
     , store.orig_store_nr    
     , store.move_to_store_id 
     , store.move_store_desc
     , store.dashboard_relevant_fg
FROM   P_LEW_MART_MSI_AC.v_org_store_merge_2 store
WHERE  store.aspect_id = 2
AND (DAT_CLOSING IS NULL OR DAT_CLOSING BETWEEN  DATEADD(DAYS, -366, CURRENT_DATE()) AND CURRENT_DATE)
;