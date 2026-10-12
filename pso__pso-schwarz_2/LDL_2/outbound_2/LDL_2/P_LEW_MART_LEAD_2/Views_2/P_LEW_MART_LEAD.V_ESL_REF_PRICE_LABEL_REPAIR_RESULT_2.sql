/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_ESL_REF_PRICE_LABEL_REPAIR_RESULT_2 
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_esl_ref_price_label_repair_result_2 (price_label_repair_result_cd,
price_label_repair_result_descr, price_label_producer_name) AS SELECT price_label_repair_result_cd,
 price_label_repair_result_descr,
 price_label_producer_name
FROM ldl_p_lew_core_ac.v_esl_ref_price_label_repair_result_2;