/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_RELATED_ITEM_HIST_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_RELATED_ITEM_HIST_2
(
	 client_id
	,mdm_item_sid
	,item_rel_type_cd
	,mdm_item_sid_related
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
	,item_rel_type_cd
	,mdm_item_sid_related
	,deleted_fg
	,dwh_valid_from
	,dwh_valid_to
	,dwh_load_id
	,dwh_created
	,dwh_updated  

FROM P_LEW_CORE_AC.V_MDM_ITEM_RELATED_ITEM_HIST_2
WHERE  CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
  AND deleted_fg=0;