/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_REF_MDM_ITEM_WORKFLOW_STATUS_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_APOLLO.V_REF_MDM_ITEM_WORKFLOW_STATUS_1 
(
	 client_id
	,workflow_status_id
	,workflow_status
	,dwh_load_id
	,dwh_created
	,dwh_updated     
)
AS
    SELECT 
	 client_id
	,workflow_status_id
	,workflow_status
	,dwh_load_id
	,dwh_created
	,dwh_updated      

FROM P_LEW_CORE_AC.V_REF_MDM_ITEM_WORKFLOW_STATUS_1;