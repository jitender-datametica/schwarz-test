/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_PRICE_LABEL_STORE_RMA
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  1.11.2025	  DMITRY ZAYTSEV	INITIAL SETUP
#  1.1  25.11.2025  Marvin Rekovsky Add natural key for itemgroup and subitemgroup
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW  P_LEW_MART_LEAD_AC.V_ESL_PRICE_LABEL_STORE_RMA
(
   INT_ID
  ,CLIENT_ID
  ,WH_ID
  ,MOVE_TO_STORE_ID
  ,ASPECT_ID
  ,PRICE_LABEL_PRODUCER_NAME
  ,ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
  ,DAT_FORMDATE
  ,CURRENCY_ISO_CD
  ,ITEM_GRP_INT_SID
  ,SUB_ITEM_GRP_SID
  ,ITEMGROUP_INT_ID
  ,SUBITEMGROUP_ID
  ,PRICE_LABEL_DAMAGE_REASON_ID   
  ,RMA_LABELS
) AS
SELECT 
   int_id
  ,client_id
  ,wh_id
  ,move_to_store_id
  ,aspect_id
  ,price_label_producer_name
  ,electronic_price_label_type_cd_fe
  ,dat_formdate
  ,currency_iso_cd
  ,item_grp_int_sid
  ,sub_item_grp_sid
  ,itemgroup_int_id
  ,subitemgroup_id
  ,price_label_damage_reason_id   
  ,rma_labels
	
FROM p_lew_mart_lead.v_esl_price_label_store_rma
;