/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_PRICE_LABEL_STORE_RMA_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  1.11.2025	  DMITRY ZAYTSEV	INITIAL SETUP
#  1.1  25.11.2025  Marvin Rekovsky Add natural key for itemgroup_1 and subitemgroup
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_esl_price_label_store_rma_1 (int_id, client_id, wh_id, move_to_store_id,
aspect_id, price_label_producer_name, electronic_price_label_type_cd_fe, dat_formdate, currency_iso_cd, item_grp_int_sid
, sub_item_grp_sid, itemgroup_int_id, subitemgroup_id, price_label_damage_reason_id, rma_labels) AS SELECT *
FROM ldl_p_lew_mart_lead.v_esl_price_label_store_rma_1;