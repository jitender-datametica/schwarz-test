/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_RMA_LABELS_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	 INITIAL SETUP
#  1.1  24.11.2025  DMITRY ZAYTSEV   NEW FIELDS ADDED
#  1.2  25.11.2025  Marvin Rekovsky Add natural key for itemgroup_1 and subitemgroup
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ESL_RMA_LABELS_GRP_1
(
   INT_ID
	,CLIENT_ID
	,MOVE_TO_STORE_ID
	,WH_ID
	,ASPECT_ID
	,PRICE_LABEL_PRODUCER_NAME
	,ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
	,DAT_FORMDATE
    ,ITEM_GRP_INT_SID
    ,SUB_ITEM_GRP_SID
	,ITEMGROUP_INT_ID
	,SUBITEMGROUP_ID
    ,PRICE_LABEL_DAMAGE_REASON_ID
	,ANALYSED_LABELS
	,DEFECT_LABELS
	,NOTDEFECT_LABELS
	,WARRANTY_LABELS
	,DEFECTPRICE_USD
	,DEFECTPRICE_CUR
	,CURRENCY_ISO_CD
) AS
SELECT 
  int_id
 ,client_id
 ,move_to_store_id
 ,wh_id
 ,aspect_id
 ,price_label_producer_name
 ,electronic_price_label_type_cd_fe
 ,dat_formdate
 ,item_grp_int_sid
 ,sub_item_grp_sid
 ,itemgroup_int_id
 ,subitemgroup_id
 ,price_label_damage_reason_id
 ,analysed_labels
 ,defect_labels
 ,notdefect_labels
 ,warranty_labels
 ,defectprice_usd
 ,defectprice_cur
 ,currency_iso_cd
	
FROM p_lew_mart_lead.v_esl_rma_labels_grp_1
;