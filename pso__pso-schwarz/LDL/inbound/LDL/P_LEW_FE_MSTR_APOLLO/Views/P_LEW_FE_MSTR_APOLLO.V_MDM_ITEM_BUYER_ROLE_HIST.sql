/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_BUYER_ROLE_HIST
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_BUYER_ROLE_HIST
(
	client_id
	,mdm_item_sid
	,buyer_sid
	,role_type_cd
	,deleted_fg
	,dwh_valid_from
	,dwh_valid_to
	,dwh_load_id
	,dwh_created
	,dwh_updated      
)
AS
    SELECT 
 	client_id
	,mdm_item_sid
	,buyer_sid
	,role_type_cd
	,deleted_fg
	,dwh_valid_from
	,dwh_valid_to
	,dwh_load_id
	,dwh_created
	,dwh_updated    

FROM P_LEW_CORE_AC.V_MDM_ITEM_BUYER_ROLE_HIST
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
  AND deleted_fg=0
  AND role_type_cd='EKL';