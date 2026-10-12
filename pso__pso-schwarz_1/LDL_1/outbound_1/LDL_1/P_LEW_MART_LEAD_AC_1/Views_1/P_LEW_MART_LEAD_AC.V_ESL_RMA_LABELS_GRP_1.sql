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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_esl_rma_labels_grp_1 (int_id, client_id, move_to_store_id, wh_id,
aspect_id, price_label_producer_name, electronic_price_label_type_cd_fe, dat_formdate, item_grp_int_sid,
sub_item_grp_sid, itemgroup_int_id, subitemgroup_id, price_label_damage_reason_id, analysed_labels, defect_labels,
notdefect_labels, warranty_labels, defectprice_usd, defectprice_cur, currency_iso_cd) AS SELECT *
FROM ldl_p_lew_mart_lead.v_esl_rma_labels_grp_1;