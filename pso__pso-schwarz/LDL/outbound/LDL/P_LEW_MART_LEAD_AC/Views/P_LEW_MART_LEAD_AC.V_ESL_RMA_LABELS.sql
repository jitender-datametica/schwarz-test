/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_RMA_LABELS
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_esl_rma_labels (int_id, client_id, move_to_store_id, wh_id, aspect_id,
price_label_producer_name, electronic_price_label_type_cd_fe, dat_formdate, analysed_labels, defect_labels,
notdefect_labels, warranty_labels, defectprice_usd, defectprice_cur, currency_iso_cd) AS SELECT *
FROM ldl_p_lew_mart_lead.v_esl_rma_labels;