/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_RELATED_ITEM_HIST_PRED2_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_RELATED_ITEM_HIST_PRED2_1
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
    ,mdm_item_sid_PRED2      --Vorgänger-Nr. INT
)
AS
    SELECT 
   	 rih1.client_id
	,rih1.mdm_item_sid
	,rih1.item_rel_type_cd
	,rih1.mdm_item_sid_related
	,rih1.deleted_fg
	,rih1.dwh_valid_from
	,rih1.dwh_valid_to
	,rih1.dwh_load_id
	,rih1.dwh_created
	,rih1.dwh_updated
    ,ri1.item_ian           

FROM P_LEW_CORE_AC.V_MDM_ITEM_RELATED_ITEM_HIST_1 rih1
LEFT OUTER JOIN P_LEW_CORE.T_MDM_ITEM_1 ri1
  ON rih1.mdm_item_sid_related=ri1.mdm_item_sid
WHERE  CURRENT_DATE BETWEEN rih1.dwh_valid_from AND rih1.dwh_valid_to
  AND rih1.deleted_fg=0
  AND rih1.item_rel_type_cd='PRED2'
;